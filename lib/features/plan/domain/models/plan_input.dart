/// 训练计划规则引擎的输入模型。
///
/// 规则引擎不直接依赖 Isar / Riverpod，方便独立测试与后续接入
/// Coros 等外部数据源。
library;

/// 单次历史跑步摘要（规则引擎只关心这三个字段）。
class RunSummary {
  final DateTime startTime;
  final double distanceKm;
  final int durationSeconds;

  const RunSummary({
    required this.startTime,
    required this.distanceKm,
    required this.durationSeconds,
  });

  /// 平均配速（秒/公里），数据异常时返回 0。
  double get paceSecondsPerKm {
    if (distanceKm <= 0 || durationSeconds <= 0) return 0;
    return durationSeconds / distanceKm;
  }
}

/// 生成周计划所需的全部输入。
class PlanInput {
  /// 建档中的当前周跑量（公里/周）。
  final double? weeklyMileage;

  /// 目标赛事类型，例如「全程马拉松」「半程马拉松」「10公里」。
  final String? targetRaceType;

  /// 目标完赛时间，例如「3:30:00」「1:45」「210」。
  final String? targetRaceTime;

  /// 可训练时间描述，例如「每周3-4天，早晚各1小时」。
  final String? availableTrainingDays;

  /// 伤病史描述，非空即视为需要保守处理。
  final String? injuryHistory;

  /// 最近跑步记录（引擎内部只会使用参考日期前 28 天的数据）。
  final List<RunSummary> recentRuns;

  /// 生成计划的参考日期，默认当前时间；测试时可注入。
  final DateTime? referenceDate;

  const PlanInput({
    this.weeklyMileage,
    this.targetRaceType,
    this.targetRaceTime,
    this.availableTrainingDays,
    this.injuryHistory,
    this.recentRuns = const [],
    this.referenceDate,
  });

  bool get hasInjuryHistory =>
      injuryHistory != null && injuryHistory!.trim().isNotEmpty;

  DateTime get effectiveReferenceDate => referenceDate ?? DateTime.now();
}
