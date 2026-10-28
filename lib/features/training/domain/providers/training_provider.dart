import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/training_task_repository.dart';
import '../models/training_task.dart';
import '../../../plan/domain/models/training_plan.dart';

final trainingTaskRepositoryProvider =
    Provider<TrainingTaskRepository>((ref) => TrainingTaskRepository());

final trainingTasksProvider =
    StateNotifierProvider<TrainingTasksNotifier, List<TrainingTask>>((ref) {
  return TrainingTasksNotifier(ref.watch(trainingTaskRepositoryProvider));
});

/// 训练任务列表与完成态。
///
/// 任务本身由周计划生成后通过 [replaceAll] 写入；完成/跳过状态在此持久化，
/// 供周计划页、今日训练页共用。
class TrainingTasksNotifier extends StateNotifier<List<TrainingTask>> {
  TrainingTasksNotifier(this._repository) : super(const <TrainingTask>[]) {
    ready = _restore();
  }

  final TrainingTaskRepository _repository;

  late final Future<void> ready;
  DateTime? weekStart;

  Future<void> _restore() async {
    final StoredTrainingTasks? stored = await _repository.load();
    if (stored == null) return;
    if (!isSameWeek(stored.weekStart, DateTime.now())) return;
    weekStart = stored.weekStart;
    state = stored.tasks;
  }

  TrainingTask? taskById(String taskId) {
    for (final TrainingTask task in state) {
      if (task.id == taskId) return task;
    }
    return null;
  }

  TrainingTask? taskForDate(DateTime date) {
    for (final TrainingTask task in state) {
      if (isSameDay(task.date, date)) return task;
    }
    return null;
  }

  TrainingTask? getTodayTask([DateTime? date]) => taskForDate(date ?? DateTime.now());

  Future<void> replaceAll(
    List<TrainingTask> tasks, {
    required DateTime weekStart,
  }) async {
    this.weekStart = weekStart;
    state = tasks;
    await _repository.save(weekStart, tasks);
  }

  Future<void> markCompleted(String taskId, [String? runRecordId]) async {
    await _updateStatus(
      taskId,
      TrainingTaskStatus.completed,
      runRecordId: runRecordId,
    );
  }

  Future<void> markSkipped(String taskId) async {
    await _updateStatus(taskId, TrainingTaskStatus.skipped);
  }

  Future<void> markPending(String taskId) async {
    await _updateStatus(taskId, TrainingTaskStatus.pending);
  }

  Future<void> _updateStatus(
    String taskId,
    TrainingTaskStatus status, {
    String? runRecordId,
  }) async {
    bool changed = false;
    state = <TrainingTask>[
      for (final TrainingTask task in state)
        if (task.id == taskId)
          () {
            changed = true;
            return task.copyWith(status: status, runRecordId: runRecordId);
          }()
        else
          task,
    ];
    if (!changed) return;
    final DateTime week = weekStart ??
        startOfWeek(
          state
                  .firstWhere((TrainingTask task) => task.id == taskId)
                  .date ??
              DateTime.now(),
        );
    await _repository.save(week, state);
  }
}
