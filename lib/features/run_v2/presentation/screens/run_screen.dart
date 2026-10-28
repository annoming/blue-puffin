import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../training/domain/providers/training_provider.dart';
import '../../domain/providers/run_provider.dart';

class RunScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? extra;
  const RunScreen({super.key, this.extra});

  @override
  ConsumerState<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends ConsumerState<RunScreen> {
  bool isRunning = false;
  String? runId;

  @override
  Widget build(BuildContext context) {
    final fromTraining = widget.extra?['fromTraining'] == true;
    final taskId = widget.extra?['taskId'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(fromTraining && taskId != null ? '训练关联跑步' : '跑步'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fromTraining && taskId != null) ...[
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text(
                        '计划关联跑步',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('训练任务: $taskId'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Text(
              '00:00:00',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '0.00 公里',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              '配速: --',
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!isRunning) {
                    setState(() {
                      isRunning = true;
                      runId = ref.read(runRecordsProvider.notifier).startRun(trainingTaskId: taskId);
                    });
                  } else {
                    // 完成跑步
                    if (runId != null) {
                      ref.read(runRecordsProvider.notifier).completeRun(runId!, trainingTaskId: taskId);
                    }
                    if (fromTraining && taskId != null) {
                      ref.read(trainingTasksProvider.notifier).markCompleted(runId ?? 'run_completed', taskId);
                    }
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('跑步完成'),
                        content: Text(fromTraining && taskId != null
                            ? '跑步记录已关联训练任务并标记完成'
                            : '跑步记录已保存'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                              context.go('/');
                            },
                            child: const Text('确定'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text(isRunning ? '结束跑步' : '开始跑步'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
