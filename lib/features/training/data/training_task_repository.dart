import 'dart:convert';

import '../../../core/storage/storage_service.dart';
import '../domain/models/training_task.dart';

/// 持久化后的任务集合（按周组织）。
class StoredTrainingTasks {
  final DateTime weekStart;
  final List<TrainingTask> tasks;

  const StoredTrainingTasks({required this.weekStart, required this.tasks});
}

/// 训练任务的本地持久化。
///
/// 任务状态（完成/跳过/关联跑步记录）需要跨重启保留，按周存一份 JSON；
/// 重新生成计划时整份覆盖。
class TrainingTaskRepository {
  static const String _tasksKey = 'training_tasks_v1';
  static const int schemaVersion = 1;

  Future<StorageService> get _storage => StorageService.init();

  Future<StoredTrainingTasks?> load() async {
    final StorageService storage = await _storage;
    final String? raw = storage.getString(_tasksKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      if (decoded['schemaVersion'] != schemaVersion) return null;
      final DateTime? weekStart =
          DateTime.tryParse(decoded['weekStart'] as String? ?? '');
      final Object? taskList = decoded['tasks'];
      if (weekStart == null || taskList is! List<dynamic>) return null;
      return StoredTrainingTasks(
        weekStart: weekStart,
        tasks: taskList
            .whereType<Map<String, dynamic>>()
            .map(TrainingTask.fromJson)
            .toList(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> save(DateTime weekStart, List<TrainingTask> tasks) async {
    final StorageService storage = await _storage;
    await storage.setString(
      _tasksKey,
      jsonEncode(<String, dynamic>{
        'schemaVersion': schemaVersion,
        'weekStart': weekStart.toIso8601String(),
        'tasks': tasks.map((TrainingTask task) => task.toJson()).toList(),
      }),
    );
  }

  Future<void> clear() async {
    final StorageService storage = await _storage;
    await storage.setString(_tasksKey, '');
  }
}
