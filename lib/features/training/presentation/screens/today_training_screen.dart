import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/training_provider.dart';

class TodayTrainingScreen extends ConsumerWidget {
  const TodayTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(trainingTasksProvider);
    final todayTask = ref.read(trainingTasksProvider.notifier).getTodayTask();

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日训练'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今日训练计划',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (tasks.isEmpty)
              const Text('暂无训练计划')
            else
              Card(
                child: ListTile(
                  title: Text(todayTask?.title ?? tasks.first.title),
                  subtitle: Text(
                    '类型: ${_getTypeText(todayTask?.type ?? tasks.first.type)} | '
                    '${todayTask?.distanceKm != null ? "${todayTask?.distanceKm}公里" : ""} '
                    '${todayTask?.durationMin != null ? "${todayTask?.durationMin}分钟" : ""}',
                  ),
                  trailing: todayTask?.completed ?? tasks.first.completed
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.chevron_right),
                  onTap: () {
                    context.push('/training/task/${todayTask?.id ?? tasks.first.id}');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'easy':
        return '轻松跑';
      case 'tempo':
        return '节奏跑';
      case 'long_run':
        return '长距离';
      case 'interval':
        return '间歇跑';
      case 'rest':
        return '休息';
      default:
        return type;
    }
  }
}
