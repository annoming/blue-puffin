import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_task.dart';

final trainingTasksProvider = StateNotifierProvider<TrainingTasksNotifier, List<TrainingTask>>((ref) {
  return TrainingTasksNotifier();
});

class TrainingTasksNotifier extends StateNotifier<List<TrainingTask>> {
  TrainingTasksNotifier()
      : super([
          TrainingTask(
            id: 'task_001',
            title: '今日训练 - 恢复跑',
            type: 'easy',
            distanceKm: 5,
            durationMin: 35,
            description: '以轻松配速完成5公里，重点关注放松',
            guidance: '跑前热身10分钟，注意呼吸节奏，避免过快起步。',
          ),
        ]);

  void markCompleted(String taskId, String runRecordId) {
    state = [
      for (final task in state)
        if (task.id == taskId)
          task.copyWith(completed: true)
        else
          task
    ];
  }

  TrainingTask? getTodayTask() {
    if (state.isEmpty) return null;
    try {
      return state.firstWhere((t) => !t.completed);
    } catch (e) {
      return state.first;
    }
  }
}
