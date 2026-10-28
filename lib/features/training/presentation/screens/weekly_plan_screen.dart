import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../plan/domain/models/training_plan.dart';
import '../../../plan/domain/providers/plan_provider.dart';
import '../../domain/models/training_task.dart';
import '../../domain/providers/training_provider.dart';
import '../widgets/plan_widgets.dart';

enum _SessionAction { startRun, complete, skip, reset }

class WeeklyPlanScreen extends ConsumerStatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  ConsumerState<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends ConsumerState<WeeklyPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainingPlanProvider.notifier).ensureCurrentPlan();
    });
  }

  Future<void> _regenerate() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('重新生成本周计划'),
        content: const Text('将根据最新的建档信息和跑步记录覆盖本周计划，完成/跳过状态会重置。'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('重新生成'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(trainingPlanProvider.notifier).regenerate();
    if (!mounted) return;
    final String? error = ref.read(trainingPlanProvider).error;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ?? '已重新生成本周计划')),
    );
  }

  Future<void> _openSession(PlanSession session) async {
    final List<TrainingTask> tasks = ref.read(trainingTasksProvider);
    TrainingTask? task;
    for (final TrainingTask item in tasks) {
      if (isSameDay(item.date, session.date)) {
        task = item;
        break;
      }
    }

    final _SessionAction? action = await showModalBottomSheet<_SessionAction>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) => _SessionSheet(
        session: session,
        task: task,
      ),
    );
    if (action == null || !mounted || task == null) return;

    final TrainingPlanNotifier notifier =
        ref.read(trainingPlanProvider.notifier);
    switch (action) {
      case _SessionAction.startRun:
        await notifier.setActiveTaskId(task.id);
        if (!mounted) return;
        context.push(
          '/run',
          extra: <String, dynamic>{
            'fromTraining': true,
            'taskId': task.id,
          },
        );
        break;
      case _SessionAction.complete:
        await notifier.markCompleted(task.id);
        break;
      case _SessionAction.skip:
        await notifier.markSkipped(task.id);
        break;
      case _SessionAction.reset:
        await notifier.markPending(task.id);
        break;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_actionMessage(action))),
    );
  }

  String _actionMessage(_SessionAction action) {
    switch (action) {
      case _SessionAction.startRun:
        return '已记录待关联的训练任务';
      case _SessionAction.complete:
        return '已标记完成';
      case _SessionAction.skip:
        return '已跳过本次训练';
      case _SessionAction.reset:
        return '已恢复为待完成';
    }
  }

  @override
  Widget build(BuildContext context) {
    final PlanState state = ref.watch(trainingPlanProvider);
    final List<TrainingTask> tasks = ref.watch(trainingTasksProvider);
    final TrainingPlan? plan = state.plan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('个性化训练计划'),
        actions: <Widget>[
          IconButton(
            tooltip: '重新生成',
            onPressed: state.isLoading ? null : _regenerate,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(state, tasks, plan),
    );
  }

  Widget _buildBody(
    PlanState state,
    List<TrainingTask> tasks,
    TrainingPlan? plan,
  ) {
    if (plan == null) {
      if (state.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return _EmptyPlan(
        error: state.error,
        notice: state.notice,
        onGenerate: () =>
            ref.read(trainingPlanProvider.notifier).ensureCurrentPlan(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(trainingPlanProvider.notifier).regenerate(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          if (state.isLoading) const LinearProgressIndicator(),
          _PlanHeader(plan: plan),
          if (state.notice != null) ...<Widget>[
            const SizedBox(height: 12),
            _NoticeCard(message: state.notice!),
          ],
          if (state.error != null) ...<Widget>[
            const SizedBox(height: 12),
            _ErrorCard(message: state.error!),
          ],
          const SizedBox(height: 12),
          _VolumeCard(plan: plan),
          const SizedBox(height: 12),
          _SafetyCard(tips: plan.safetyTips),
          const SizedBox(height: 12),
          ...plan.sessions.map(
            (PlanSession session) => _SessionCard(
              session: session,
              task: _taskForSession(tasks, session),
              onTap: () => _openSession(session),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '第 ${plan.version} 版 · 生成于 ${_formatTime(plan.generatedAt)}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  TrainingTask? _taskForSession(
    List<TrainingTask> tasks,
    PlanSession session,
  ) {
    if (!session.isRunning) return null;
    for (final TrainingTask task in tasks) {
      if (isSameDay(task.date, session.date)) return task;
    }
    return null;
  }

  String _formatTime(DateTime time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '${formatPlanDate(time)} $hour:$minute';
  }
}

class _PlanHeader extends StatelessWidget {
  const _PlanHeader({required this.plan});

  final TrainingPlan plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '本周训练计划',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Chip(
                  label: Text(plan.volumeSource.label),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(formatWeekRange(plan.weekStart)),
            const SizedBox(height: 12),
            Text(
              plan.goalSummary,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                _Stat(
                  label: '本周跑量',
                  value: '${plan.totalDistanceKm.toStringAsFixed(1)} km',
                ),
                const SizedBox(width: 24),
                _Stat(label: '训练次数', value: '${plan.runningSessionCount} 次'),
                if (plan.conservativeFactor < 1) ...<Widget>[
                  const SizedBox(width: 24),
                  _Stat(
                    label: '保守系数',
                    value: plan.conservativeFactor.toStringAsFixed(2),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _VolumeCard extends StatelessWidget {
  const _VolumeCard({required this.plan});

  final TrainingPlan plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.insights, size: 18),
                SizedBox(width: 6),
                Text('本周跑量依据', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            Text(plan.volumeExplanation),
            const SizedBox(height: 6),
            Text(
              '基准周跑量 ${plan.baselineWeeklyKm.toStringAsFixed(1)} km · '
              '目标 ${plan.targetWeeklyKm.toStringAsFixed(1)} km',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard({required this.tips});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: const Icon(Icons.shield_outlined),
        title: const Text('安全提示'),
        subtitle: Text('${tips.length} 条训练安全建议'),
        children: tips
            .map(
              (String tip) => ListTile(
                dense: true,
                leading: const Icon(Icons.check_circle_outline, size: 18),
                title: Text(tip),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.task,
    required this.onTap,
  });

  final PlanSession session;
  final TrainingTask? task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isToday = isSameDay(session.date, DateTime.now());
    final bool isPast = session.date.isBefore(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    final String subtitle = session.isRest
        ? session.description
        : '${session.distanceKm.toStringAsFixed(1)} km · '
            '${session.durationMin} 分钟 · ${session.description}';

    return Opacity(
      opacity: isPast && !isToday ? 0.6 : 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        shape: isToday
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
              )
            : null,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: planTypeColor(session.type.code),
            child: Icon(
              session.isRest ? Icons.bedtime_outlined : Icons.directions_run,
              size: 20,
            ),
          ),
          title: Row(
            children: <Widget>[
              Expanded(child: Text(session.title)),
              if (isToday)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Chip(
                    label: Text('今天'),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              taskStatusChip(task),
            ],
          ),
          subtitle: Text(
            '${sessionDateLabel(session.date)} · '
            '${sessionTypeLabel(session.type)} · $subtitle',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class _SessionSheet extends StatelessWidget {
  const _SessionSheet({required this.session, required this.task});

  final PlanSession session;
  final TrainingTask? task;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 4),
            Text(
              '${sessionDateLabel(session.date)} · ${sessionTypeLabel(session.type)}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            if (!session.isRest) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                '距离 ${session.distanceKm.toStringAsFixed(1)} km · '
                '预计 ${session.durationMin} 分钟',
              ),
            ],
            const SizedBox(height: 12),
            Text(session.description),
            const SizedBox(height: 12),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('提示：${session.guidance}'),
              ),
            ),
            if (session.isRest) ...<Widget>[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('知道了'),
                ),
              ),
            ] else if (task == null) ...<Widget>[
              const SizedBox(height: 16),
              const Text('任务已重新生成，请关闭后刷新列表。'),
            ] else ...<Widget>[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  if (task!.isPending)
                    FilledButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pop(_SessionAction.startRun),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('开始跑步'),
                    ),
                  if (task!.isPending)
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.of(context).pop(_SessionAction.complete),
                      child: const Text('标记完成'),
                    ),
                  if (task!.isPending)
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(_SessionAction.skip),
                      child: const Text('跳过'),
                    ),
                  if (!task!.isPending)
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.of(context).pop(_SessionAction.reset),
                      child: const Text('恢复待完成'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: ListTile(
        leading: const Icon(Icons.info_outline),
        title: Text(message),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade50,
      child: ListTile(
        leading: const Icon(Icons.error_outline),
        title: Text(message),
      ),
    );
  }
}

class _EmptyPlan extends StatelessWidget {
  const _EmptyPlan({
    required this.error,
    required this.notice,
    required this.onGenerate,
  });

  final String? error;
  final String? notice;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.calendar_month, size: 64),
            const SizedBox(height: 16),
            const Text(
              '还没有本周训练计划',
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
              onPressed: onGenerate,
              child: const Text('生成本周计划'),
            ),
          ],
        ),
      ),
    );
  }
}
