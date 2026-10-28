import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../plan/domain/models/training_plan.dart';
import '../../../plan/domain/providers/plan_provider.dart';
import '../../domain/models/training_task.dart';
import '../../domain/providers/training_provider.dart';
import '../widgets/plan_widgets.dart';

class TodayTrainingScreen extends ConsumerStatefulWidget {
  const TodayTrainingScreen({super.key});

  @override
  ConsumerState<TodayTrainingScreen> createState() =>
      _TodayTrainingScreenState();
}

class _TodayTrainingScreenState extends ConsumerState<TodayTrainingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainingPlanProvider.notifier).ensureCurrentPlan();
    });
  }

  Future<void> _startRun(TrainingTask task) async {
    await ref.read(trainingPlanProvider.notifier).setActiveTaskId(task.id);
    if (!mounted) return;
    context.push('/run');
  }

  @override
  Widget build(BuildContext context) {
    final PlanState state = ref.watch(trainingPlanProvider);
    final List<TrainingTask> tasks = ref.watch(trainingTasksProvider);
    final TrainingPlan? plan = state.plan;
    final DateTime now = DateTime.now();
    final PlanSession? todaySession = plan?.sessionForDate(now);
    TrainingTask? todayTask;
    for (final TrainingTask task in tasks) {
      if (isSameDay(task.date, now)) {
        todayTask = task;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日训练'),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.push('/training/plan'),
            child: const Text('本周计划'),
          ),
        ],
      ),
      body: _buildBody(state, todaySession, todayTask),
    );
  }

  Widget _buildBody(
    PlanState state,
    PlanSession? session,
    TrainingTask? task,
  ) {
    if (state.isLoading && state.plan == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.plan == null) {
      return _EmptyToday(
        error: state.error,
        notice: state.notice,
        onOpenPlan: () => context.push('/training/plan'),
      );
    }

    if (session == null) {
      return _EmptyToday(
        error: null,
        notice: '今天不在本周计划范围内，去计划页查看完整安排。',
        onOpenPlan: () => context.push('/training/plan'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _TodayHeader(session: session),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        session.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    taskStatusChip(task),
                  ],
                ),
                const SizedBox(height: 8),
                Text(session.description),
                if (!session.isRest) ...<Widget>[
                  const SizedBox(height: 8),
                  Text(
                    '距离 ${session.distanceKm.toStringAsFixed(1)} km · '
                    '预计 ${session.durationMin} 分钟',
                  ),
                ],
                const SizedBox(height: 12),
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('提示：${session.guidance}'),
                  ),
                ),
                if (!session.isRest) ...<Widget>[
                  const SizedBox(height: 16),
                  _TaskActions(
                    task: task,
                    onStartRun: task == null ? null : () => _startRun(task),
                    onComplete: task == null
                        ? null
                        : () => ref
                            .read(trainingPlanProvider.notifier)
                            .markCompleted(task.id),
                    onSkip: task == null
                        ? null
                        : () => ref
                            .read(trainingPlanProvider.notifier)
                            .markSkipped(task.id),
                    onReset: task == null
                        ? null
                        : () => ref
                            .read(trainingPlanProvider.notifier)
                            .markPending(task.id),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('查看本周完整计划'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/training/plan'),
          ),
        ),
      ],
    );
  }
}

class _TodayHeader extends StatelessWidget {
  const _TodayHeader({required this.session});

  final PlanSession session;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: planTypeColor(session.type.code),
          child: Icon(
            session.isRest ? Icons.bedtime_outlined : Icons.directions_run,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sessionDateLabel(session.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              sessionTypeLabel(session.type),
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }
}

class _TaskActions extends StatelessWidget {
  const _TaskActions({
    required this.task,
    required this.onStartRun,
    required this.onComplete,
    required this.onSkip,
    required this.onReset,
  });

  final TrainingTask? task;
  final VoidCallback? onStartRun;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      return const Text('任务已重新生成，请刷新本周计划。');
    }
    if (task!.isPending) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          FilledButton.icon(
            onPressed: onStartRun,
            icon: const Icon(Icons.play_arrow),
            label: const Text('开始跑步'),
          ),
          OutlinedButton(
            onPressed: onComplete,
            child: const Text('标记完成'),
          ),
          TextButton(
            onPressed: onSkip,
            child: const Text('跳过'),
          ),
        ],
      );
    }
    return Row(
      children: <Widget>[
        Text('本次训练${task!.status.label}'),
        const SizedBox(width: 12),
        TextButton(
          onPressed: onReset,
          child: const Text('恢复待完成'),
        ),
      ],
    );
  }
}

class _EmptyToday extends StatelessWidget {
  const _EmptyToday({
    required this.error,
    required this.notice,
    required this.onOpenPlan,
  });

  final String? error;
  final String? notice;
  final VoidCallback onOpenPlan;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.event_available, size: 64),
            const SizedBox(height: 16),
            const Text(
              '今天还没有训练安排',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (notice != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(notice!, textAlign: TextAlign.center),
            ],
            if (error != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onOpenPlan,
              child: const Text('查看本周计划'),
            ),
          ],
        ),
      ),
    );
  }
}
