/// Coros 活动数据模型与字段映射。
///
/// 该文件只依赖 Dart 核心库，方便在不具备 Flutter 环境时直接做单元测试。
/// Coros 各地域 / 各接口返回的字段名存在差异（例如 `distance` 为米，
/// `distanceKm` 为公里；`startTime` 为秒级时间戳或 ISO 字符串），
/// 因此这里采用「多候选字段 + 单位归一化」的容错解析。
library;

/// Coros 运动类型编码。
///
/// 编码来源为社区逆向整理（Coros Partner API 文档需要商务审批后才可见），
/// 若后续拿到官方文档只需调整这里的常量集合。
class CorosSportType {
  static const int run = 100;
  static const int indoorRun = 101;
  static const int trailRun = 102;
  static const int trackRun = 103;

  static const Set<int> runningTypes = {run, indoorRun, trailRun, trackRun};

  static const List<String> _runKeywords = [
    'run',
    'running',
    'jog',
    'trail',
    'track',
    '跑',
    '越野',
  ];

  static const List<String> _nonRunKeywords = [
    'ride',
    'bike',
    'cycling',
    'swim',
    'walk',
    'hike',
    'strength',
    '骑行',
    '游泳',
    '徒步',
    '力量',
  ];

  static bool isRunning({int? sportType, String? title}) {
    if (sportType != null && runningTypes.contains(sportType)) {
      return true;
    }

    final name = (title ?? '').toLowerCase();
    if (name.isEmpty) return false;

    if (_nonRunKeywords.any(name.contains)) return false;
    return _runKeywords.any(name.contains);
  }
}

/// 一条已完成（或已上传）的 Coros 活动。
class CorosActivity {
  CorosActivity({
    required this.externalId,
    required this.startTime,
    required this.durationSeconds,
    required this.distanceMeters,
    this.title,
    this.sportType,
    this.avgHeartRate,
    this.calories,
    this.raw = const {},
  });

  /// Coros 侧活动 ID，用于去重（同一活动重复同步时覆盖而不是新增）。
  final String externalId;

  /// 活动开始时间，统一按 UTC 保存，展示时再转本地时区。
  final DateTime startTime;

  final int durationSeconds;
  final double distanceMeters;
  final String? title;
  final int? sportType;
  final int? avgHeartRate;
  final int? calories;
  final Map<String, dynamic> raw;

  double get distanceKm => distanceMeters / 1000;

  /// 配速：秒/公里；距离过短或为 0 时返回 null，避免除零。
  double? get paceSecondsPerKm {
    if (distanceMeters <= 0 || durationSeconds <= 0) return null;
    return durationSeconds / distanceKm;
  }

  /// 形如 `5'30"` 的配速文本。
  String? get formattedPace {
    final pace = paceSecondsPerKm;
    if (pace == null || !pace.isFinite || pace <= 0) return null;
    final total = pace.round();
    final minutes = total ~/ 60;
    final seconds = total % 60;
    return "$minutes'${seconds.toString().padLeft(2, '0')}\"";
  }

  bool get isRunning => CorosSportType.isRunning(sportType: sportType, title: title);

  /// 里程与时长必须为正数，否则视为无有效训练数据的记录。
  bool get hasUsableMetrics => distanceMeters > 0 && durationSeconds > 0;

  String get dedupeKey => 'coros:$externalId';

  Map<String, dynamic> toJson() => {
        'externalId': externalId,
        'startTime': startTime.toUtc().toIso8601String(),
        'durationSeconds': durationSeconds,
        'distanceMeters': distanceMeters,
        if (title != null) 'title': title,
        if (sportType != null) 'sportType': sportType,
        if (avgHeartRate != null) 'avgHeartRate': avgHeartRate,
        if (calories != null) 'calories': calories,
      };

  /// 解析失败返回 null（调用方记录为「跳过」），不抛出异常中断整批同步。
  static CorosActivity? tryParse(Map<String, dynamic> json) {
    final externalId = _readString(json, const [
      'id',
      'activityId',
      'activity_id',
      'labelId',
      'label_id',
      'sportId',
    ]);
    final startTime = _readDateTime(json, const [
      'startTime',
      'start_time',
      'beginTime',
      'begin_time',
      'startTimestamp',
      'start',
    ]);
    if (externalId == null || startTime == null) return null;

    final durationSeconds = _readDurationSeconds(json);
    final distanceMeters = _readDistanceMeters(json);

    return CorosActivity(
      externalId: externalId,
      startTime: startTime,
      durationSeconds: durationSeconds,
      distanceMeters: distanceMeters,
      title: _readString(json, const ['name', 'title', 'remark', 'activityName']),
      sportType: _readInt(json, const ['sportType', 'sport_type', 'mode', 'type']),
      avgHeartRate: _readInt(json, const [
        'avgHeartRate',
        'avg_heart_rate',
        'avgHr',
        'averageHeartRate',
      ]),
      calories: _readInt(json, const ['calories', 'totalCalories', 'energy']),
      raw: json,
    );
  }
}

String? _readString(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value == null) continue;
    if (value is String && value.trim().isNotEmpty) return value.trim();
    if (value is num) return value.toString();
  }
  return null;
}

int? _readInt(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.round();
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
  }
  return null;
}

num? _readNum(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is num) return value;
    if (value is String) {
      final parsed = num.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
  }
  return null;
}

/// 时间支持：秒级时间戳、毫秒级时间戳、ISO-8601 字符串。
DateTime? _readDateTime(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value == null) continue;

    if (value is num) {
      return _fromEpoch(value.round());
    }
    if (value is String) {
      final raw = value.trim();
      final numeric = int.tryParse(raw);
      if (numeric != null) return _fromEpoch(numeric);

      final parsed = DateTime.tryParse(raw);
      if (parsed != null) {
        return parsed.isUtc ? parsed : DateTime.utc(
          parsed.year,
          parsed.month,
          parsed.day,
          parsed.hour,
          parsed.minute,
          parsed.second,
          parsed.millisecond,
          parsed.microsecond,
        );
      }
    }
  }
  return null;
}

DateTime _fromEpoch(int value) {
  // 毫秒级时间戳从 2001 年起就超过 1e12，秒级时间戳到 2286 年才到 1e10。
  if (value > 100000000000) {
    return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
  }
  return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true);
}

/// 时长以秒返回。支持 `durationSeconds` / `durationMs` 显式字段，
/// 以及社区接口常见的 `duration` / `totalTime`（秒）。
int _readDurationSeconds(Map<String, dynamic> json) {
  final explicitMs = _readNum(json, const ['durationMs', 'duration_ms', 'elapsedTimeMs']);
  if (explicitMs != null) return (explicitMs / 1000).round();

  final seconds = _readNum(json, const [
    'durationSeconds',
    'duration_seconds',
    'duration',
    'totalTime',
    'total_time',
    'workoutTime',
    'movingTime',
  ]);
  if (seconds == null) return 0;
  return seconds.round();
}

/// 距离统一为米。优先使用显式的公里字段，避免把 `5.2` 当成 5.2 米。
double _readDistanceMeters(Map<String, dynamic> json) {
  final km = _readNum(json, const ['distanceKm', 'distance_km', 'totalDistanceKm']);
  if (km != null) return km * 1000;

  final meters = _readNum(json, const [
    'distanceMeters',
    'distance_meters',
    'distance',
    'totalDistance',
    'total_distance',
  ]);
  if (meters == null) return 0;
  return meters.toDouble();
}
