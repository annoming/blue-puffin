import 'dart:math' as math;

import '../models/plan_input.dart';
import '../models/training_plan.dart';

/// 规则版训练计划引擎（无状态、纯 Dart，可单独测试）。
///
/// 设计原则：
/// 1. 有历史数据时以近 4 周加权周跑量为基准，每周增幅控制在 5%（低于常见的 10% 上限）；
/// 2. 无历史数据时依次回退到建档周跑量、保守起步跑量；
/// 3. 伤病史触发 0.85 保守系数、减少训练天数并取消高强度课；
/// 4. 所有计划都附带安全提示，不追求极限。
class TrainingPlanEngine {
  const TrainingPlanEngine();

  static const double defaultWeeklyKm = 12.0;
  static const int historyWindowDays = 28;
  static const double weeklyGrowth = 1.05;
  static const double injuryFactor = 0.85;
  static const double minWeeklyKm = 4.0;
  static const double maxWeeklyKm = 120.0;

  static const Map<int, List<PlanSessionType>> _layouts = {
    2: [
      PlanSessionType.rest,
      PlanSessionType.rest,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.rest,
      PlanSessionType.rest,
      PlanSessionType.longRun,
    ],
    3: [
      PlanSessionType.rest,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.tempo,
      PlanSessionType.rest,
      PlanSessionType.rest,
      PlanSessionType.longRun,
    ],
    4: [
      PlanSessionType.rest,
      PlanSessionType.tempo,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.longRun,
    ],
    5: [
      PlanSessionType.easy,
      PlanSessionType.tempo,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.easy,
      PlanSessionType.rest,
      PlanSessionType.longRun,
    ],
    6: [
      PlanSessionType.easy,
      PlanSessionType.tempo,
      PlanSessionType.easy,
      PlanSessionType.easy,
      PlanSessionType.tempo,
      PlanSessionType.rest,
      PlanSessionType.longRun,
    ],
  };

  TrainingPlan generate(PlanInput input) {
    final DateTime now = input.effectiveReferenceDate;
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime weekStart = _startOfWeek(today);

    final List<RunSummary> history = _recentHistory(input.recentRuns, today);
    final _Volume volume = _resolveVolume(input, history);

    int sessionCount = _parseTrainingDays(input.availableTrainingDays);
    if (input.hasInjuryHistory) {
      sessionCount -= 1;
    }
    if (volume.source == PlanVolumeSource.defaultConservative) {
      sessionCount = math.min(sessionCount, 3);
    }
    sessionCount = sessionCount.clamp(2, 6).toInt();

    final bool canQuality =
        volume.source == PlanVolumeSource.recentRuns && !input.hasInjuryHistory;
    final bool canInterval = canQuality && volume.baselineKm >= 35;

    final List<PlanSessionType> layout =
        List<PlanSessionType>.from(_layouts[sessionCount]!);
    if (!canQuality) {
      for (int i = 0; i < layout.length; i++) {
        if (layout[i] == PlanSessionType.tempo ||
            layout[i] == PlanSessionType.interval) {
          layout[i] = PlanSessionType.easy;
        }
      }
    } else if (!canInterval) {
      for (int i = 0; i < layout.length; i++) {
        if (layout[i] == PlanSessionType.interval) {
          layout[i] = PlanSessionType.tempo;
        }
      }
    } else {
      // 6 天计划中把周五的节奏跑升级为间歇跑，保证两次强度间隔 72 小时。
      for (int i = 0; i < layout.length; i++) {
        if (layout[i] == PlanSessionType.tempo && i >= 4) {
          layout[i] = PlanSessionType.interval;
        }
      }
    }

    final double targetKm = _targetWeeklyKm(volume, input);
    final List<double> distances = _allocateDistances(
      layout: layout,
      targetKm: targetKm,
      hasInjury: input.hasInjuryHistory,
      volumeSource: volume.source,
      longRunCap: _longRunCap(input.targetRaceType, input.hasInjuryHistory,
          volume.source),
    );

    final double? goalPace = _goalPaceSecondsPerKm(input);
    final double easyBasePace = _easyBasePace(goalPace, history);
    final DateTime nowStamp = now;

    final List<PlanSession> sessions = <PlanSession>[];
    for (int i = 0; i < layout.length; i++) {
      final PlanSessionType type = layout[i];
      final DateTime date = weekStart.add(Duration(days: i));
      final double distanceKm = distances[i];
      final double pace = _paceFor(type, easyBasePace, goalPace);
      final int durationMin = type == PlanSessionType.rest
          ? 0
          : math.max(10, (distanceKm * pace / 60).round());

      sessions.add(
        PlanSession(
          date: date,
          type: type,
          title: _titleFor(type, distanceKm),
          distanceKm: distanceKm,
          durationMin: durationMin,
          description: _descriptionFor(type, input.hasInjuryHistory),
          guidance: _guidanceFor(type, input.hasInjuryHistory),
          isKeySession:
              type == PlanSessionType.longRun || type == PlanSessionType.interval,
        ),
      );
    }

    return TrainingPlan(
      weekStart: weekStart,
      baselineWeeklyKm: _roundToHalf(volume.baselineKm),
      targetWeeklyKm: _roundToHalf(targetKm),
      conservativeFactor: input.hasInjuryHistory ? injuryFactor : 1.0,
      volumeSource: volume.source,
      hasInjuryHistory: input.hasInjuryHistory,
      goalSummary: _goalSummary(input),
      volumeExplanation: _volumeExplanation(
        volume: volume,
        targetKm: targetKm,
        history: history,
        hasInjury: input.hasInjuryHistory,
      ),
      safetyTips: _safetyTips(
        hasInjury: input.hasInjuryHistory,
        source: volume.source,
        hasQuality: layout.contains(PlanSessionType.tempo) ||
            layout.contains(PlanSessionType.interval),
      ),
      sessions: sessions,
      generatedAt: nowStamp,
    );
  }

  List<RunSummary> _recentHistory(List<RunSummary> runs, DateTime today) {
    return runs.where((RunSummary run) {
      if (run.distanceKm <= 0) return false;
      final DateTime day = DateTime(
        run.startTime.year,
        run.startTime.month,
        run.startTime.day,
      );
      final int daysAgo = today.difference(day).inDays;
      return daysAgo >= 0 && daysAgo < historyWindowDays;
    }).toList();
  }

  _Volume _resolveVolume(PlanInput input, List<RunSummary> history) {
    if (history.isNotEmpty) {
      double last14 = 0;
      double prev14 = 0;
      double total = 0;
      final DateTime today = DateTime(
        input.effectiveReferenceDate.year,
        input.effectiveReferenceDate.month,
        input.effectiveReferenceDate.day,
      );
      for (final RunSummary run in history) {
        total += run.distanceKm;
        final DateTime day =
            DateTime(run.startTime.year, run.startTime.month, run.startTime.day);
        if (today.difference(day).inDays < 14) {
          last14 += run.distanceKm;
        } else {
          prev14 += run.distanceKm;
        }
      }

      double baseline;
      if (last14 <= 0) {
        baseline = prev14 / 2;
      } else if (prev14 <= 0) {
        baseline = last14 / 2;
      } else {
        baseline = (last14 / 2) * 0.65 + (prev14 / 2) * 0.35;
      }
      if (baseline <= 0) {
        baseline = total / 4;
      }
      return _Volume(
        baselineKm: baseline.clamp(minWeeklyKm, maxWeeklyKm).toDouble(),
        source: PlanVolumeSource.recentRuns,
      );
    }

    final double? mileage = input.weeklyMileage;
    if (mileage != null && mileage > 0) {
      return _Volume(
        baselineKm: mileage.clamp(minWeeklyKm, maxWeeklyKm).toDouble(),
        source: PlanVolumeSource.profileMileage,
      );
    }

    return const _Volume(
      baselineKm: defaultWeeklyKm,
      source: PlanVolumeSource.defaultConservative,
    );
  }

  double _targetWeeklyKm(_Volume volume, PlanInput input) {
    double growth = 1.0;
    if (volume.source == PlanVolumeSource.recentRuns) {
      growth = weeklyGrowth;
    }
    double target = volume.baselineKm * growth;
    if (input.hasInjuryHistory) {
      target *= injuryFactor;
      target = math.min(target, volume.baselineKm);
    }
    return target.clamp(minWeeklyKm, maxWeeklyKm).toDouble();
  }

  List<double> _allocateDistances({
    required List<PlanSessionType> layout,
    required double targetKm,
    required bool hasInjury,
    required PlanVolumeSource volumeSource,
    required double longRunCap,
  }) {
    final List<int> runningIndices = <int>[];
    final List<int> qualityIndices = <int>[];
    final List<int> easyIndices = <int>[];
    int longIndex = -1;

    for (int i = 0; i < layout.length; i++) {
      final PlanSessionType type = layout[i];
      if (type == PlanSessionType.rest) continue;
      runningIndices.add(i);
      if (type == PlanSessionType.longRun) {
        longIndex = i;
      } else if (type == PlanSessionType.easy) {
        easyIndices.add(i);
      } else {
        qualityIndices.add(i);
      }
    }

    final bool smallVolume = targetKm < 15;
    final double minLong = smallVolume ? 3.0 : 5.0;
    final double minEasy = smallVolume ? 2.0 : 3.0;
    final double minQuality = smallVolume ? 3.0 : 4.0;

    double longShare;
    if (layout.length >= 5) {
      longShare = 0.26;
    } else if (layout.length == 4) {
      longShare = 0.28;
    } else {
      longShare = 0.30;
    }
    if (hasInjury) longShare = math.min(longShare, 0.25);
    if (volumeSource == PlanVolumeSource.defaultConservative) {
      longShare = math.min(longShare, 0.30);
    }

    double longKm = _roundToHalf(
      (targetKm * longShare).clamp(minLong, longRunCap).toDouble(),
    );

    double qualityShareTotal = 0;
    if (qualityIndices.isNotEmpty) {
      qualityShareTotal = layout.length <= 4 ? 0.22 : 0.34;
    }
    final double qualityEach = qualityIndices.isEmpty
        ? 0.0
        : _roundToHalf(
            (targetKm * qualityShareTotal / qualityIndices.length)
                .clamp(minQuality, 16.0)
                .toDouble(),
          );

    final double easyEach = easyIndices.isEmpty
        ? 0.0
        : _roundToHalf(
            ((targetKm -
                        longKm -
                        qualityEach * qualityIndices.length) /
                    easyIndices.length)
                .clamp(minEasy, 18.0)
                .toDouble(),
          );

    final List<double> distances = List<double>.filled(layout.length, 0);
    distances[longIndex] = longKm;
    for (final int index in qualityIndices) {
      distances[index] = qualityEach;
    }
    for (final int index in easyIndices) {
      distances[index] = easyEach;
    }

    final double allocated =
        distances.fold<double>(0, (double sum, double value) => sum + value);
    double diff = targetKm - allocated;
    if (diff.abs() >= 0.25) {
      final double adjusted =
          (distances[longIndex] + diff).clamp(minLong, longRunCap).toDouble();
      distances[longIndex] = _roundToHalf(adjusted);
    }

    return distances;
  }

  double _scorePace(double pace) => pace.clamp(240.0, 540.0).toDouble();

  double _paceFor(
    PlanSessionType type,
    double easyBasePace,
    double? goalPace,
  ) {
    switch (type) {
      case PlanSessionType.rest:
        return 0.0;
      case PlanSessionType.easy:
        return _scorePace(easyBasePace);
      case PlanSessionType.longRun:
        return _scorePace(easyBasePace + 10);
      case PlanSessionType.tempo:
        final double tempoBase = goalPace ?? (easyBasePace - 20);
        return _scorePace(tempoBase - 5);
      case PlanSessionType.interval:
        final double intervalBase = goalPace ?? (easyBasePace - 30);
        return _scorePace(intervalBase - 25);
    }
  }

  double _easyBasePace(double? goalPace, List<RunSummary> history) {
    if (goalPace != null) {
      return _scorePace(goalPace + 45);
    }
    double totalDistance = 0;
    double totalSeconds = 0;
    for (final RunSummary run in history) {
      if (run.paceSecondsPerKm > 0) {
        totalDistance += run.distanceKm;
        totalSeconds += run.paceSecondsPerKm * run.distanceKm;
      }
    }
    if (totalDistance > 0) {
      final double historyPace = totalSeconds / totalDistance;
      return _scorePace(historyPace + 15);
    }
    return 390; // 默认 6:30/km
  }

  double? _goalPaceSecondsPerKm(PlanInput input) {
    final int? seconds = _parseRaceTime(input.targetRaceTime);
    final double? distance = _raceDistanceKm(input.targetRaceType);
    if (seconds == null || distance == null || distance <= 0) {
      return null;
    }
    return seconds / distance;
  }

  String _titleFor(PlanSessionType type, double distanceKm) {
    if (type == PlanSessionType.rest) return '休息日';
    return '${type.label} ${_formatKm(distanceKm)} km';
  }

  String _descriptionFor(PlanSessionType type, bool hasInjury) {
    switch (type) {
      case PlanSessionType.rest:
        return '完全休息，或进行 20-30 分钟拉伸与泡沫轴放松。';
      case PlanSessionType.easy:
        if (hasInjury) {
          return '以无痛为前提的轻松跑，主动降低配速与距离，重点恢复。';
        }
        return '以可以正常聊天的轻松配速完成，重点是有氧积累。';
      case PlanSessionType.tempo:
        return '热身后以略快于目标配速的节奏跑，提升乳酸阈值。';
      case PlanSessionType.interval:
        return '热身后进行分组快跑与慢跑恢复，注意保持动作放松。';
      case PlanSessionType.longRun:
        return '以轻松配速完成本周最长距离，后半程保持稳定。';
    }
  }

  String _guidanceFor(PlanSessionType type, bool hasInjury) {
    final String base;
    switch (type) {
      case PlanSessionType.rest:
        base = '保证睡眠与蛋白质摄入；可用泡沫轴放松小腿、髂胫束。';
        break;
      case PlanSessionType.easy:
        base = '跑前动态热身 5-10 分钟；全程鼻吸口呼，心率过高时主动降速。';
        break;
      case PlanSessionType.tempo:
        base = '先慢跑 10 分钟热身，节奏段保持呼吸可控，结束后慢跑放松 5 分钟。';
        break;
      case PlanSessionType.interval:
        base = '充分热身后再提速；每组之间慢跑恢复，动作变形立即结束。';
        break;
      case PlanSessionType.longRun:
        base = '提前补水，跑前 1-2 小时补充易消化碳水；后半程不要加速冲刺。';
        break;
    }
    if (hasInjury && type != PlanSessionType.rest) {
      return '$base 如有旧伤部位不适，立即停止并改为休息。';
    }
    return base;
  }

  String _goalSummary(PlanInput input) {
    final String type = input.targetRaceType?.trim() ?? '';
    final String time = input.targetRaceTime?.trim() ?? '';
    if (type.isEmpty && time.isEmpty) {
      return '暂未设置目标赛事：按健康跑与养成习惯安排，不追求配速。';
    }
    final StringBuffer buffer = StringBuffer('目标');
    if (type.isNotEmpty) {
      buffer.write('：$type');
    }
    if (time.isNotEmpty) {
      buffer.write(' $time');
    }
    final int? seconds = _parseRaceTime(time);
    final double? distance = _raceDistanceKm(type);
    if (seconds != null && distance != null && distance > 0) {
      buffer.write('（目标配速 ${_formatPace(seconds / distance)}/km）');
    }
    return buffer.toString();
  }

  String _volumeExplanation({
    required _Volume volume,
    required double targetKm,
    required List<RunSummary> history,
    required bool hasInjury,
  }) {
    final StringBuffer buffer = StringBuffer();
    switch (volume.source) {
      case PlanVolumeSource.recentRuns:
        final double total = history.fold<double>(
          0,
          (double sum, RunSummary run) => sum + run.distanceKm,
        );
        buffer.write(
          '近 28 天共 ${history.length} 次跑步、${total.toStringAsFixed(1)} km，'
          '加权周跑量 ${volume.baselineKm.toStringAsFixed(1)} km；'
          '本周按 +5% 渐进，目标 ${targetKm.toStringAsFixed(1)} km。',
        );
        break;
      case PlanVolumeSource.profileMileage:
        buffer.write(
          '暂无近 28 天跑步记录，按建档周跑量 '
          '${volume.baselineKm.toStringAsFixed(1)} km 保持，本周不增加跑量。',
        );
        break;
      case PlanVolumeSource.defaultConservative:
        buffer.write(
          '暂无历史跑步数据和建档跑量，采用保守起步：每周约 '
          '${defaultWeeklyKm.toStringAsFixed(0)} km，优先建立规律训练习惯。',
        );
        break;
    }
    if (hasInjury) {
      buffer.write(' 因存在伤病史，跑量已乘以保守系数 ${injuryFactor.toStringAsFixed(2)}，'
          '并取消高强度课。');
    }
    return buffer.toString();
  }

  List<String> _safetyTips({
    required bool hasInjury,
    required PlanVolumeSource source,
    required bool hasQuality,
  }) {
    final List<String> tips = <String>[];
    if (hasInjury) {
      tips.add('检测到伤病史：本周计划已降量并取消高强度课。训练中如有疼痛立即停止，'
          '持续不适请咨询运动医学或康复专业人士。');
    }
    if (source == PlanVolumeSource.defaultConservative) {
      tips.add('因为暂无历史数据，本计划采用保守起步：前 2 周不追求配速，'
          '以每周稳定完成训练为目标。');
    }
    tips.add('遵循「每周跑量增幅不超过 10%」原则；本计划已按 5% 渐进，'
        '疲劳或睡眠不足时优先减量。');
    if (hasQuality) {
      tips.add('高强度课之间至少间隔 48 小时，强度日前后安排轻松跑或休息。');
    }
    tips.add('每次训练包含 5-10 分钟热身与放松，长距离后及时补水并补充碳水与蛋白质。');
    tips.add('出现持续疼痛、头晕、胸闷或心率异常时停止训练并及时就医。');
    return tips;
  }

  double _longRunCap(
    String? raceType,
    bool hasInjury,
    PlanVolumeSource source,
  ) {
    final String type = (raceType ?? '').toLowerCase();
    double cap;
    if (type.contains('半') || type.contains('half')) {
      cap = 18;
    } else if (type.contains('全') ||
        type.contains('full') ||
        type.contains('马拉松')) {
      cap = 32;
    } else if (type.contains('10')) {
      cap = 12;
    } else if (type.contains('5')) {
      cap = 8;
    } else {
      cap = 16;
    }
    if (hasInjury) {
      cap = math.min(cap, 12);
    }
    if (source == PlanVolumeSource.defaultConservative) {
      cap = math.min(cap, 10);
    } else if (source == PlanVolumeSource.profileMileage) {
      cap = math.min(cap, 16);
    }
    return cap;
  }

  DateTime _startOfWeek(DateTime date) {
    final DateTime day = DateTime(date.year, date.month, date.day);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  int _parseTrainingDays(String? raw) {
    if (raw == null || raw.trim().isEmpty) return 3;
    final Iterable<RegExpMatch> matches = RegExp(r'\d+').allMatches(raw);
    if (matches.isEmpty) {
      if (raw.contains('每天') || raw.contains('每日')) return 5;
      if (raw.contains('周末')) return 2;
      return 3;
    }
    final int first = int.tryParse(matches.first.group(0)!) ?? 3;
    if (first <= 0) return 2;
    return first.clamp(2, 6).toInt();
  }

  int? _parseRaceTime(String? raw) {
    if (raw == null) return null;
    final String text = raw.trim().replaceAll('：', ':');
    if (text.isEmpty) return null;
    final List<String> parts = text.split(':');
    final List<int> values = <int>[];
    for (final String part in parts) {
      final int? value = int.tryParse(part.trim());
      if (value == null || value < 0) return null;
      values.add(value);
    }
    if (values.length == 1) return values[0] * 60;
    if (values.length == 2) return values[0] * 3600 + values[1] * 60;
    if (values.length == 3) {
      return values[0] * 3600 + values[1] * 60 + values[2];
    }
    return null;
  }

  double? _raceDistanceKm(String? raceType) {
    if (raceType == null || raceType.trim().isEmpty) return null;
    final String type = raceType.toLowerCase();
    if (type.contains('半') || type.contains('half')) return 21.0975;
    if (type.contains('全') ||
        type.contains('full') ||
        type.contains('马拉松')) {
      return 42.195;
    }
    if (type.contains('10')) return 10;
    if (type.contains('5')) return 5;
    return null;
  }

  double _roundToHalf(double value) => (value * 2).round() / 2;

  String _formatKm(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }

  String _formatPace(double secondsPerKm) {
    final int total = secondsPerKm.round();
    final int minutes = total ~/ 60;
    final int seconds = total % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _Volume {
  final double baselineKm;
  final PlanVolumeSource source;

  const _Volume({required this.baselineKm, required this.source});
}
