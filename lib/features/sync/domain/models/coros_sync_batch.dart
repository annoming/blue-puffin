import 'coros_activity.dart';

/// 单条被跳过的 Coros 记录及原因，便于展示同步明细。
class CorosSkippedRecord {
  const CorosSkippedRecord({
    required this.reason,
    this.externalId,
    this.title,
  });

  final String reason;
  final String? externalId;
  final String? title;

  String get reasonLabel {
    switch (reason) {
      case 'not_running':
        return '非跑步运动';
      case 'invalid_metrics':
        return '里程或时长无效';
      default:
        return '数据不完整';
    }
  }
}

/// 一批待入库的 Coros 跑步记录 + 跳过统计。
class CorosSyncBatch {
  const CorosSyncBatch({
    required this.activities,
    required this.skippedCount,
    required this.skippedRecords,
  });

  final List<CorosActivity> activities;
  final int skippedCount;
  final List<CorosSkippedRecord> skippedRecords;
}

/// 纯函数：原始活动 → 去重后的跑步记录。
///
/// 只保留跑步类活动，且里程、时长必须有效；解析失败、非跑步、
/// 无有效数据的记录计入跳过统计，不中断整批同步。
class CorosSyncPlanner {
  static CorosSyncBatch collect(
    Iterable<Map<String, dynamic>> items, {
    int maxSkipDetails = 20,
  }) {
    final activities = <CorosActivity>[];
    final skipped = <CorosSkippedRecord>[];
    var skippedCount = 0;

    void skip(CorosSkippedRecord record) {
      skippedCount += 1;
      if (skipped.length < maxSkipDetails) skipped.add(record);
    }

    for (final raw in items) {
      final activity = CorosActivity.tryParse(raw);
      if (activity == null) {
        skip(const CorosSkippedRecord(reason: 'parse_failed'));
        continue;
      }
      if (!activity.isRunning) {
        skip(CorosSkippedRecord(
          reason: 'not_running',
          externalId: activity.externalId,
          title: activity.title,
        ));
        continue;
      }
      if (!activity.hasUsableMetrics) {
        skip(CorosSkippedRecord(
          reason: 'invalid_metrics',
          externalId: activity.externalId,
          title: activity.title,
        ));
        continue;
      }
      activities.add(activity);
    }

    // 同一活动在分页边界重复出现时按 externalId 去重，保留最后一次。
    final unique = <String, CorosActivity>{};
    for (final activity in activities) {
      unique[activity.externalId] = activity;
    }

    return CorosSyncBatch(
      activities: unique.values.toList(growable: false),
      skippedCount: skippedCount,
      skippedRecords: skipped,
    );
  }
}

class CorosSyncResult {
  const CorosSyncResult({
    required this.imported,
    required this.updated,
    required this.skipped,
    required this.syncedAt,
    this.skippedRecords = const [],
  });

  final int imported;
  final int updated;
  final int skipped;
  final DateTime syncedAt;
  final List<CorosSkippedRecord> skippedRecords;

  int get totalSynced => imported + updated;

  String get summary {
    final parts = <String>['新增 $imported 条', '更新 $updated 条'];
    if (skipped > 0) parts.add('跳过 $skipped 条');
    return parts.join('，');
  }
}
