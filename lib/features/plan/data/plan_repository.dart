import 'dart:convert';

import '../../../core/storage/storage_service.dart';
import '../domain/models/training_plan.dart';

/// 周计划的本地持久化。
///
/// 计划是一次生成出来的快照，体积小且需要整份覆盖，按 [StorageService]
/// （SharedPreferences）存 JSON；任务完成态由 training 模块单独持久化。
class PlanRepository {
  static const String _planKey = 'training_plan_v1';
  static const String _activeTaskKey = 'training_active_task_v1';

  /// 结构版本，后续字段变更时用于迁移或丢弃旧数据。
  static const int schemaVersion = 1;

  Future<StorageService> get _storage => StorageService.init();

  Future<TrainingPlan?> load() async {
    final StorageService storage = await _storage;
    final String? raw = storage.getString(_planKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      final Object? version = decoded['schemaVersion'];
      if (version != schemaVersion) return null;
      final Object? planJson = decoded['plan'];
      if (planJson is! Map<String, dynamic>) return null;
      return TrainingPlan.fromJson(planJson);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(TrainingPlan plan) async {
    final StorageService storage = await _storage;
    await storage.setString(
      _planKey,
      jsonEncode(<String, dynamic>{
        'schemaVersion': schemaVersion,
        'plan': plan.toJson(),
      }),
    );
  }

  Future<void> clear() async {
    final StorageService storage = await _storage;
    await storage.setString(_planKey, '');
  }

  /// 记录「即将开始的训练任务」，供跑步链路（ANNO-8）读取并关联。
  Future<void> setActiveTaskId(String taskId) async {
    final StorageService storage = await _storage;
    await storage.setString(_activeTaskKey, taskId);
  }

  Future<String?> getActiveTaskId() async {
    final StorageService storage = await _storage;
    final String? taskId = storage.getString(_activeTaskKey);
    if (taskId == null || taskId.isEmpty) return null;
    return taskId;
  }

  Future<void> clearActiveTaskId() async {
    final StorageService storage = await _storage;
    await storage.setString(_activeTaskKey, '');
  }
}
