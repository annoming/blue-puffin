import 'package:isar/isar.dart';

part 'run_record_model.g.dart';

/// 统一的跑步记录。
///
/// 本地跑步（source = `local`）与 Coros 同步（source = `coros`）共用一张表，
/// 训练计划复盘、跑量统计只需要读这一张表。
/// `(source, externalId)` 唯一索引保证重复同步不会产生重复记录。
@collection
class RunRecordModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true, composite: [CompositeIndex('externalId')])
  String source = 'local';

  String externalId = '';

  DateTime startTime = DateTime.fromMillisecondsSinceEpoch(0);

  int durationSeconds = 0;

  double distanceMeters = 0;

  String? title;

  int? sportType;

  int? avgHeartRate;

  int? calories;

  DateTime syncedAt = DateTime.now();

  DateTime createdAt = DateTime.now();

  double get distanceKm => distanceMeters / 1000;

  /// 秒/公里；距离或时长为 0 时返回 null。
  double? get paceSecondsPerKm {
    if (distanceMeters <= 0 || durationSeconds <= 0) return null;
    return durationSeconds / distanceKm;
  }

  /// 形如 `5'30"` 的配速文本。
  String? get formattedPace {
    final pace = paceSecondsPerKm;
    if (pace == null || !pace.isFinite || pace <= 0) return null;
    final total = pace.round();
    return "${total ~/ 60}'${(total % 60).toString().padLeft(2, '0')}\"";
  }

  /// 形如 `1:02:35` 的时长文本。
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$mm:$ss' : '$minutes:$ss';
  }

  bool get isFromCoros => source == 'coros';
}
