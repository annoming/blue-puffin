import 'package:isar/isar.dart';

import '../../../core/storage/isar_service.dart';
import '../../run/data/models/run_record_model.dart';
import '../domain/models/plan_input.dart';

/// 读取跑步历史，供规则引擎计算基准周跑量。
///
/// 本地跑步与 Coros 同步记录统一存储在 [RunRecordModel]。
/// 当数据库尚未注册跑步记录 schema（例如首次启动的旧版本数据层）时，
/// 返回空列表，由规则引擎走保守兜底，不向用户展示假数据。
class PlanHistoryRepository {
  Future<List<RunSummary>> loadRecentRuns({DateTime? now}) async {
    try {
      final Isar db = await IsarService.getInstance();
      final DateTime since =
          (now ?? DateTime.now()).subtract(const Duration(days: 90));
      final List<RunRecordModel> records =
          await db.runRecordModels.where().findAll();
      records.sort(
        (RunRecordModel a, RunRecordModel b) =>
            b.startTime.compareTo(a.startTime),
      );
      return records
          .where((RunRecordModel record) =>
              record.distanceMeters > 0 &&
              record.startTime.isAfter(since) &&
              !record.startTime.isAfter(now ?? DateTime.now()))
          .map(
            (RunRecordModel record) => RunSummary(
              startTime: record.startTime,
              distanceKm: record.distanceKm,
              durationSeconds: record.durationSeconds,
            ),
          )
          .toList();
    } catch (_) {
      return const <RunSummary>[];
    }
  }
}
