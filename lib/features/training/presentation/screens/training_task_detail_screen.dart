import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../plan/domain/providers/plan_provider.dart';
import '../../domain/models/training_task.dart';
import '../../domain/providers/training_provider.dart';
import '../widgets/plan_widgets.dart';

/// 训练任务详情。
///
/// 路由 `/training/task/:taskId` 由路由模块统一注册后即可直接访问；
/// 未注册时周计划/今日训练页通过底部弹层展示同样的详情与操作。
class TrainingTaskDetailScreen extends ConsumerStatefulWidget {
  const TrainingTaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  @override
  ConsumerState<TrainingTaskDetailScreen> createState() =>
      _TrainingTaskDetailScreenState();
}

class _TrainingTaskDetailScreenState
    extends ConsumerState<TrainingTaskDetailScreen> {
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
    final List<TrainingTask> tasks = ref.watch(trainingTasksProvider);
    TrainingTask? task;
    for (final TrainingTask item in tasks) {
      if (item.id == widget.taskId) {
        task = item;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('训练任务详情')),
      body: task == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('任务不存在或已被重新生成的计划替换'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => context.push('/training/plan'),
                      child: const Text('查看本周计划'),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: planTypeColor(task.type),
                      child: const Icon(Icons.directions_run, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            task.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          if (task.date != null)
                            Text(
                              sessionDateLabel(task.date!),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                        ],
                      ),
                    ),
                    taskStatusChip(task),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('训练类型：${planTypeLabel(task.type)}'),
                        if (task.distanceKm != null)
                          Text('目标距离：${task.distanceKm} km'),
                        if (task.durationMin != null)
                          Text('预计时长：${task.durationMin} 分钟'),
                        const SizedBox(height: 8),
                        Text(task.description),
                      ],
                    ),
                  ),
                ),
                if (task.guidance != null) ...<Widget>[
                  const SizedBox(height: 12),
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '跑前提示',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(task.guidance!),
                        ],
                      ),
                    ),
                  ),
                ],
                if (task.runRecordId != null) ...<Widget>[
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text('已关联跑步记录'),
                      subtitle: Text(task.runRecordId!),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (task.isPending) ...<Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _startRun(task!),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('开始跑步'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(trainingPlanProvider.notifier)
                              .markCompleted(task!.id),
                          child: const Text('标记完成'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(trainingPlanProvider.notifier)
                              .markSkipped(task!.id),
                          child: const Text('跳过'),
                        ),
                      ),
                    ],
                  ),
                ] else ...<Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => ref
                          .read(trainingPlanProvider.notifier)
                          .markPending(task!.id),
                      child: const Text('恢复为待完成'),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
