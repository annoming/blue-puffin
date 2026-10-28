import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/training_provider.dart';

class TrainingTaskDetailScreen extends ConsumerWidget {
  final String taskId;
  const TrainingTaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(trainingTasksProvider);
    final task = tasks.firstWhere((t) => t.id == taskId, orElse: () => tasks.first);

    return Scaffold(
      appBar: AppBar(
        title: const Text('训练任务详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (task.guidance != null) ...[
              const Text(
                '跑前提示',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    task.guidance!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: task.completed
                    ? null
                    : () {
                        context.push('/run', extra: {
                          'fromTraining': true,
                          'taskId': task.id,
                        });
                      },
                child: Text(task.completed ? '已完成' : '开始跑步'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
