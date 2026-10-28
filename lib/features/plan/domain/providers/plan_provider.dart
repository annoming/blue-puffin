import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../../profile/data/profile_repository.dart';
import '../../../training/domain/models/training_task.dart';
import '../../../training/domain/providers/training_provider.dart';
import '../../data/active_user_repository.dart';
import '../../data/plan_history_repository.dart';
import '../../data/plan_repository.dart';
import '../models/plan_input.dart';
import '../models/training_plan.dart';
import '../rules/training_plan_engine.dart';

final planEngineProvider =
    Provider<TrainingPlanEngine>((ref) => const TrainingPlanEngine());
final planRepositoryProvider = Provider<PlanRepository>((ref) => PlanRepository());
final planHistoryRepositoryProvider =
    Provider<PlanHistoryRepository>((ref) => PlanHistoryRepository());
final activeUserRepositoryProvider =
    Provider<ActiveUserRepository>((ref) => ActiveUserRepository());

class PlanState {
  final TrainingPlan? plan;
  final bool isLoading;
  final String? error;

  /// 生成计划时的提示（例如未找到建档信息，已使用保守兜底）。
  final String? notice;

  const PlanState({
    this.plan,
    this.isLoading = false,
    this.error,
    this.notice,
  });

  PlanState copyWith({
    TrainingPlan? plan,
    bool? isLoading,
    String? error,
    String? notice,
    bool clearError = false,
    bool clearNotice = false,
  }) {
    return PlanState(
      plan: plan ?? this.plan,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      notice: clearNotice ? null : (notice ?? this.notice),
    );
  }
}

final trainingPlanProvider =
    StateNotifierProvider<TrainingPlanNotifier, PlanState>((ref) {
  return TrainingPlanNotifier(
    engine: ref.watch(planEngineProvider),
    planRepository: ref.watch(planRepositoryProvider),
    historyRepository: ref.watch(planHistoryRepositoryProvider),
    activeUserRepository: ref.watch(activeUserRepositoryProvider),
    profileRepository: ref.watch(profileRepositoryProvider),
    taskNotifier: ref.read(trainingTasksProvider.notifier),
  );
});

/// 周计划编排：读取建档 + 历史 → 规则引擎生成 → 持久化计划与任务。
class TrainingPlanNotifier extends StateNotifier<PlanState> {
  TrainingPlanNotifier({
    required TrainingPlanEngine engine,
    required PlanRepository planRepository,
    required PlanHistoryRepository historyRepository,
    required ActiveUserRepository activeUserRepository,
    required ProfileRepository profileRepository,
    required TrainingTasksNotifier taskNotifier,
  })  : _engine = engine,
        _planRepository = planRepository,
        _historyRepository = historyRepository,
        _activeUserRepository = activeUserRepository,
        _profileRepository = profileRepository,
        _taskNotifier = taskNotifier,
        super(const PlanState());

  final TrainingPlanEngine _engine;
  final PlanRepository _planRepository;
  final PlanHistoryRepository _historyRepository;
  final ActiveUserRepository _activeUserRepository;
  final ProfileRepository _profileRepository;
  final TrainingTasksNotifier _taskNotifier;

  Future<void>? _ensureFuture;
  bool _ensured = false;
  bool _generating = false;

  /// 页面进入时调用：有本周缓存则直接展示，否则按真实建档/历史生成。
  Future<void> ensureCurrentPlan() {
    if (_ensured) return Future<void>.value();
    final Future<void>? running = _ensureFuture;
    if (running != null) return running;
    final Future<void> future = _ensure()
        .whenComplete(() => _ensureFuture = null);
    _ensureFuture = future;
    return future;
  }

  Future<void> _ensure() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, clearError: true);

    TrainingPlan? saved;
    try {
      saved = await _planRepository.load();
    } catch (_) {
      saved = null;
    }

    if (saved != null && isSameWeek(saved.weekStart, DateTime.now())) {
      await _taskNotifier.ready;
      final bool needsTasks = _taskNotifier.state.isEmpty ||
          _taskNotifier.weekStart == null ||
          !isSameWeek(_taskNotifier.weekStart!, saved.weekStart);
      if (needsTasks) {
        await _taskNotifier.replaceAll(
          saved.toTrainingTasks(),
          weekStart: saved.weekStart,
        );
      }
      state = PlanState(plan: saved);
      _ensured = true;
      return;
    }

    await _generate(previous: saved);
    _ensured = true;
  }

  /// 用户主动重新生成：覆盖本周计划，版本号 +1。
  Future<void> regenerate() async {
    if (_generating) return;
    await _generate(previous: state.plan);
    _ensured = true;
  }

  Future<void> _generate({TrainingPlan? previous}) async {
    if (_generating) return;
    _generating = true;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      String? notice;
      ProfileModel? profile;
      try {
        final int? userId = await _activeUserRepository.currentUserId();
        if (userId != null) {
          profile = await _profileRepository.getProfile(userId);
        }
      } catch (_) {
        profile = null;
      }
      if (profile == null) {
        notice = '未找到建档信息，已按保守规则生成计划；完成建档后可获得更贴合的安排。';
      }

      final List<RunSummary> history =
          await _historyRepository.loadRecentRuns();
      final DateTime now = DateTime.now();

      final TrainingPlan generated = _engine.generate(
        PlanInput(
          weeklyMileage: profile?.currentWeeklyMileage,
          targetRaceType: profile?.targetRaceType,
          targetRaceTime: profile?.targetRaceTime,
          availableTrainingDays: profile?.availableTrainingDays,
          injuryHistory: profile?.injuryHistory,
          recentRuns: history,
          referenceDate: now,
        ),
      );

      final int version = previous != null &&
              isSameWeek(previous.weekStart, generated.weekStart)
          ? previous.version + 1
          : 1;
      final TrainingPlan plan = generated.withVersion(version);

      await _planRepository.save(plan);
      await _taskNotifier.replaceAll(
        plan.toTrainingTasks(),
        weekStart: plan.weekStart,
      );

      state = PlanState(plan: plan, notice: notice);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: '生成训练计划失败：$error',
      );
    } finally {
      _generating = false;
    }
  }

  Future<void> markCompleted(String taskId, {String? runRecordId}) {
    return _taskNotifier.markCompleted(taskId, runRecordId);
  }

  Future<void> markSkipped(String taskId) => _taskNotifier.markSkipped(taskId);

  Future<void> markPending(String taskId) => _taskNotifier.markPending(taskId);

  /// 记录即将开始的训练任务，跑步链路（ANNO-8）读取此值完成关联。
  Future<void> setActiveTaskId(String taskId) =>
      _planRepository.setActiveTaskId(taskId);

  Future<String?> getActiveTaskId() => _planRepository.getActiveTaskId();

  Future<void> clearActiveTaskId() => _planRepository.clearActiveTaskId();

  TrainingTask? taskForSession(PlanSession session, List<TrainingTask> tasks) {
    for (final TrainingTask task in tasks) {
      if (isSameDay(task.date, session.date)) return task;
    }
    return null;
  }
}
