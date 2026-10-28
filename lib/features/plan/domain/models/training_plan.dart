import '../../../training/domain/models/training_task.dart';

/// 训练课的类型。
enum PlanSessionType { rest, easy, tempo, longRun, interval }

extension PlanSessionTypeX on PlanSessionType {
  bool get isRunning => this != PlanSessionType.rest;

  String get label {
    switch (this) {
      case PlanSessionType.rest:
        return '休息';
      case PlanSessionType.easy:
        return '轻松跑';
      case PlanSessionType.tempo:
        return '节奏跑';
      case PlanSessionType.longRun:
        return '长距离';
      case PlanSessionType.interval:
        return '间歇跑';
    }
  }

  /// 与 TrainingTask.type 保持一致的编码。
  String get code {
    switch (this) {
      case PlanSessionType.rest:
        return 'rest';
      case PlanSessionType.easy:
        return 'easy';
      case PlanSessionType.tempo:
        return 'tempo';
      case PlanSessionType.longRun:
        return 'long_run';
      case PlanSessionType.interval:
        return 'interval';
    }
  }
}

/// 周跑量的来源，用于向用户解释计划依据。
enum PlanVolumeSource { recentRuns, profileMileage, defaultConservative }

extension PlanVolumeSourceX on PlanVolumeSource {
  String get label {
    switch (this) {
      case PlanVolumeSource.recentRuns:
        return '依据近 4 周跑步记录';
      case PlanVolumeSource.profileMileage:
        return '依据建档周跑量';
      case PlanVolumeSource.defaultConservative:
        return '保守起步（暂无数据）';
    }
  }
}

/// 一周中的某一天训练安排。
class PlanSession {
  final DateTime date;
  final PlanSessionType type;
  final String title;
  final double distanceKm;
  final int durationMin;
  final String description;
  final String guidance;
  final bool isKeySession;

  const PlanSession({
    required this.date,
    required this.type,
    required this.title,
    required this.distanceKm,
    required this.durationMin,
    required this.description,
    required this.guidance,
    this.isKeySession = false,
  });

  bool get isRest => type == PlanSessionType.rest;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type.name,
        'title': title,
        'distanceKm': distanceKm,
        'durationMin': durationMin,
        'description': description,
        'guidance': guidance,
        'isKeySession': isKeySession,
      };

  factory PlanSession.fromJson(Map<String, dynamic> json) {
    return PlanSession(
      date: DateTime.parse(json['date'] as String),
      type: PlanSessionType.values.byName(json['type'] as String),
      title: json['title'] as String? ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
      durationMin: (json['durationMin'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      guidance: json['guidance'] as String? ?? '',
      isKeySession: json['isKeySession'] as bool? ?? false,
    );
  }
}

/// 一份可直接展示的周训练计划。
class TrainingPlan {
  final DateTime weekStart;
  final double baselineWeeklyKm;
  final double targetWeeklyKm;
  final double conservativeFactor;
  final PlanVolumeSource volumeSource;
  final bool hasInjuryHistory;
  final String goalSummary;
  final String volumeExplanation;
  final List<String> safetyTips;
  final List<PlanSession> sessions;
  final DateTime generatedAt;

  /// 同一周内重新生成的版本号，从 1 开始递增。
  final int version;

  const TrainingPlan({
    required this.weekStart,
    required this.baselineWeeklyKm,
    required this.targetWeeklyKm,
    required this.conservativeFactor,
    required this.volumeSource,
    required this.hasInjuryHistory,
    required this.goalSummary,
    required this.volumeExplanation,
    required this.safetyTips,
    required this.sessions,
    required this.generatedAt,
    this.version = 1,
  });

  TrainingPlan withVersion(int version) => TrainingPlan(
        weekStart: weekStart,
        baselineWeeklyKm: baselineWeeklyKm,
        targetWeeklyKm: targetWeeklyKm,
        conservativeFactor: conservativeFactor,
        volumeSource: volumeSource,
        hasInjuryHistory: hasInjuryHistory,
        goalSummary: goalSummary,
        volumeExplanation: volumeExplanation,
        safetyTips: safetyTips,
        sessions: sessions,
        generatedAt: generatedAt,
        version: version,
      );

  DateTime get weekEnd => weekStart.add(const Duration(days: 6));

  double get totalDistanceKm => sessions.fold(
        0,
        (double sum, PlanSession session) => sum + session.distanceKm,
      );

  int get runningSessionCount =>
      sessions.where((PlanSession session) => session.isRunning).length;

  PlanSession? sessionForDate(DateTime date) {
    for (final session in sessions) {
      if (session.date.year == date.year &&
          session.date.month == date.month &&
          session.date.day == date.day) {
        return session;
      }
    }
    return null;
  }

  /// 转成现有「今日训练 / 训练任务」模块使用的任务模型。
  /// 休息日不生成任务。
  List<TrainingTask> toTrainingTasks() {
    return sessions
        .where((PlanSession session) => session.isRunning)
        .map(
          (PlanSession session) => TrainingTask(
            id: 'plan_${_compactDate(session.date)}_${session.type.code}',
            title: session.title,
            type: session.type.code,
            date: session.date,
            distanceKm: session.distanceKm.round(),
            durationMin: session.durationMin,
            description: session.description,
            guidance: session.guidance,
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'weekStart': weekStart.toIso8601String(),
        'baselineWeeklyKm': baselineWeeklyKm,
        'targetWeeklyKm': targetWeeklyKm,
        'conservativeFactor': conservativeFactor,
        'volumeSource': volumeSource.name,
        'hasInjuryHistory': hasInjuryHistory,
        'goalSummary': goalSummary,
        'volumeExplanation': volumeExplanation,
        'safetyTips': safetyTips,
        'sessions': sessions.map((PlanSession session) => session.toJson()).toList(),
        'generatedAt': generatedAt.toIso8601String(),
        'version': version,
      };

  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      weekStart: DateTime.parse(json['weekStart'] as String),
      baselineWeeklyKm: (json['baselineWeeklyKm'] as num?)?.toDouble() ?? 0,
      targetWeeklyKm: (json['targetWeeklyKm'] as num?)?.toDouble() ?? 0,
      conservativeFactor: (json['conservativeFactor'] as num?)?.toDouble() ?? 1,
      volumeSource: PlanVolumeSource.values.byName(
        json['volumeSource'] as String? ?? PlanVolumeSource.defaultConservative.name,
      ),
      hasInjuryHistory: json['hasInjuryHistory'] as bool? ?? false,
      goalSummary: json['goalSummary'] as String? ?? '',
      volumeExplanation: json['volumeExplanation'] as String? ?? '',
      safetyTips: (json['safetyTips'] as List<dynamic>? ?? const [])
          .map((dynamic item) => item.toString())
          .toList(),
      sessions: (json['sessions'] as List<dynamic>? ?? const [])
          .map((dynamic item) => PlanSession.fromJson(item as Map<String, dynamic>))
          .toList(),
      generatedAt: DateTime.parse(
        json['generatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );
  }
}

const List<String> weekdayLabels = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

String formatPlanDate(DateTime date) {
  return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
}

String formatWeekRange(DateTime weekStart) {
  final DateTime weekEnd = weekStart.add(const Duration(days: 6));
  return '${formatPlanDate(weekStart)} ~ ${formatPlanDate(weekEnd)}';
}

String _compactDate(DateTime date) {
  return '${date.year}${_twoDigits(date.month)}${_twoDigits(date.day)}';
}

String _twoDigits(int value) => value.toString().padLeft(2, '0');

/// 生成计划/检查计划时统一的「一周开始」口径：周一 00:00。
DateTime startOfWeek(DateTime date) {
  final DateTime day = DateTime(date.year, date.month, date.day);
  return day.subtract(Duration(days: day.weekday - 1));
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isSameWeek(DateTime a, DateTime b) => startOfWeek(a) == startOfWeek(b);
