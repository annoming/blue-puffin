import 'package:flutter_test/flutter_test.dart';

import 'package:blue_puffin/features/plan/domain/models/plan_input.dart';
import 'package:blue_puffin/features/plan/domain/models/training_plan.dart';
import 'package:blue_puffin/features/plan/domain/rules/training_plan_engine.dart';
import 'package:blue_puffin/features/training/domain/models/training_task.dart';

void main() {
  const TrainingPlanEngine engine = TrainingPlanEngine();
  final DateTime reference = DateTime(2026, 10, 28, 9); // 周三

  List<RunSummary> history({
    required int recentCount,
    required double recentKm,
    int previousCount = 0,
    double previousKm = 0,
  }) {
    final List<RunSummary> runs = <RunSummary>[];
    for (int i = 0; i < recentCount; i++) {
      runs.add(
        RunSummary(
          startTime: reference.subtract(Duration(days: 2 + i * 3)),
          distanceKm: recentKm,
          durationSeconds: (recentKm * 360).round(),
        ),
      );
    }
    for (int i = 0; i < previousCount; i++) {
      runs.add(
        RunSummary(
          startTime: reference.subtract(Duration(days: 16 + i * 2)),
          distanceKm: previousKm,
          durationSeconds: (previousKm * 360).round(),
        ),
      );
    }
    return runs;
  }

  group('无数据兜底', () {
    test('无建档无历史时生成保守周计划', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(referenceDate: reference),
      );

      expect(plan.volumeSource, PlanVolumeSource.defaultConservative);
      expect(plan.sessions.length, 7);
      expect(plan.runningSessionCount, 3);
      expect(plan.totalDistanceKm, greaterThan(0));
      expect(plan.conservativeFactor, 1.0);
      expect(
        plan.sessions.every(
          (PlanSession session) =>
              session.type != PlanSessionType.tempo &&
              session.type != PlanSessionType.interval,
        ),
        isTrue,
      );
      expect(
        plan.safetyTips.any((String tip) => tip.contains('暂无历史数据')),
        isTrue,
      );
      expect(plan.volumeExplanation, contains('保守起步'));
      expect(plan.goalSummary, contains('暂未设置目标赛事'));
    });

    test('仅有建档跑量时保持跑量、不安排强度课', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(
          weeklyMileage: 30,
          availableTrainingDays: '每周3天',
          referenceDate: reference,
        ),
      );

      expect(plan.volumeSource, PlanVolumeSource.profileMileage);
      expect(plan.baselineWeeklyKm, 30);
      expect(plan.targetWeeklyKm, 30);
      expect(plan.runningSessionCount, 3);
      expect(
        plan.sessions.any(
          (PlanSession session) =>
              session.type == PlanSessionType.tempo ||
              session.type == PlanSessionType.interval,
        ),
        isFalse,
      );
      expect(plan.volumeExplanation, contains('不增加跑量'));
    });
  });

  group('依据真实历史生成', () {
    test('近 4 周加权跑量作为基准并渐进 5%', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(
          recentRuns: history(
            recentCount: 3,
            recentKm: 10,
            previousCount: 2,
            previousKm: 10,
          ),
          availableTrainingDays: '每周4天',
          referenceDate: reference,
        ),
      );

      // (30/2)*0.65 + (20/2)*0.35 = 13.25，展示值四舍五入到 0.5
      expect(plan.baselineWeeklyKm, closeTo(13.5, 0.01));
      expect(plan.volumeSource, PlanVolumeSource.recentRuns);
      expect(plan.targetWeeklyKm, greaterThan(plan.baselineWeeklyKm));
      expect(plan.targetWeeklyKm, lessThanOrEqualTo(plan.baselineWeeklyKm * 1.1));
      expect(plan.runningSessionCount, 4);
      expect(
        plan.sessions.any(
          (PlanSession session) => session.type == PlanSessionType.tempo,
        ),
        isTrue,
      );
      expect(plan.sessions.length, 7);
    });

    test('目标赛事与完赛时间换算目标配速', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(
          targetRaceType: '半程马拉松',
          targetRaceTime: '1:45:00',
          recentRuns: history(recentCount: 6, recentKm: 8),
          availableTrainingDays: '每周4天',
          referenceDate: reference,
        ),
      );

      expect(plan.goalSummary, contains('半程马拉松'));
      expect(plan.goalSummary, contains('4:59/km'));
      final double longDistance = plan.sessions
          .firstWhere((PlanSession session) => session.type == PlanSessionType.longRun)
          .distanceKm;
      expect(longDistance, lessThanOrEqualTo(18));
    });

    test('10 公里目标同样可解析', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(
          targetRaceType: '10公里',
          targetRaceTime: '50:00',
          weeklyMileage: 25,
          referenceDate: reference,
        ),
      );
      expect(plan.goalSummary, contains('10公里'));
      expect(plan.goalSummary, contains('5:00/km'));
    });

    test('可跑天数按描述解析，最多 6 天', () {
      final TrainingPlan twoDays = engine.generate(
        PlanInput(
          recentRuns: history(recentCount: 4, recentKm: 5),
          availableTrainingDays: '每周2天',
          referenceDate: reference,
        ),
      );
      expect(twoDays.runningSessionCount, 2);

      final TrainingPlan sixDays = engine.generate(
        PlanInput(
          recentRuns: history(recentCount: 8, recentKm: 8),
          availableTrainingDays: '每天都可以，每周6天',
          referenceDate: reference,
        ),
      );
      expect(sixDays.runningSessionCount, 6);
    });
  });

  group('伤病与安全', () {
    test('伤病史触发保守系数、减天并取消高强度', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(
          recentRuns: history(recentCount: 6, recentKm: 10),
          availableTrainingDays: '每周4天',
          injuryHistory: '右膝旧伤，跑量大会疼',
          referenceDate: reference,
        ),
      );

      expect(plan.hasInjuryHistory, isTrue);
      expect(plan.conservativeFactor, 0.85);
      expect(plan.targetWeeklyKm, lessThan(plan.baselineWeeklyKm));
      expect(plan.runningSessionCount, 3);
      expect(
        plan.sessions.any(
          (PlanSession session) =>
              session.type == PlanSessionType.tempo ||
              session.type == PlanSessionType.interval,
        ),
        isFalse,
      );
      expect(
        plan.safetyTips.any((String tip) => tip.contains('伤病史')),
        isTrue,
      );
      expect(plan.volumeExplanation, contains('保守系数'));
    });
  });

  group('计划结构与序列化', () {
    test('7 天连续日期且任务 ID 唯一', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(referenceDate: reference),
      );

      expect(plan.weekStart.weekday, DateTime.monday);
      for (int i = 0; i < plan.sessions.length; i++) {
        expect(
          plan.sessions[i].date.difference(plan.weekStart).inDays,
          i,
        );
      }
      final List<TrainingTask> tasks = plan.toTrainingTasks();
      expect(tasks.length, plan.runningSessionCount);
      expect(tasks.map((TrainingTask task) => task.id).toSet().length, tasks.length);
      expect(
        tasks.every(
          (TrainingTask task) =>
              task.date != null && task.distanceKm != null && task.durationMin! > 0,
        ),
        isTrue,
      );
    });

    test('计划 JSON 往返保留版本与安全提示', () {
      final TrainingPlan plan = engine.generate(
        PlanInput(referenceDate: reference),
      ).withVersion(3);

      final TrainingPlan restored = TrainingPlan.fromJson(plan.toJson());

      expect(restored.version, 3);
      expect(restored.weekStart, plan.weekStart);
      expect(restored.sessions.length, plan.sessions.length);
      expect(restored.safetyTips.length, plan.safetyTips.length);
      expect(restored.totalDistanceKm, plan.totalDistanceKm);
    });
  });
}
