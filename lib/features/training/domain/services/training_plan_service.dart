import '../models/weekly_plan.dart';
import '../../../profile/data/models/profile_model.dart';

class TrainingPlanService {
  WeeklyPlan generateWeeklyPlan({
    ProfileModel? profile,
    int syncedRunsCount = 0,
  }) {
    // 基于建档和历史数据生成周训练计划（规则版）
    double baseMileage = profile?.currentWeeklyMileage ?? 15.0;
    
    // 历史数据为空时的兜底逻辑 - 保守系数
    if (syncedRunsCount == 0) {
      baseMileage = baseMileage > 20 ? 15.0 : baseMileage * 0.7;
    }
    
    // 保守系数和安全提示
    final adjustedMileage = baseMileage * 0.8;
    
    final days = <WeeklyPlanDay>[
      WeeklyPlanDay(
        dayOfWeek: 1,
        type: 'rest',
        title: '休息日',
        description: '充分休息，恢复身体机能',
        guidance: '注意休息，适当拉伸放松',
      ),
      WeeklyPlanDay(
        dayOfWeek: 2,
        type: 'easy',
        title: '轻松跑',
        description: '以舒适配速完成跑步，建立有氧基础',
        distanceKm: (adjustedMileage * 0.3).round(),
        guidance: '跑前热身5-10分钟，配速要能说话的程度，避免过快起步。',
      ),
      WeeklyPlanDay(
        dayOfWeek: 3,
        type: 'tempo',
        title: '节奏跑',
        description: '包含节奏段落的跑步，提升乳酸阈值',
        distanceKm: (adjustedMileage * 0.25).round(),
        guidance: '热身充分，节奏段落控制在舒适偏累不至于崩溃的强度。',
      ),
      WeeklyPlanDay(
        dayOfWeek: 4,
        type: 'rest',
        title: '交叉训练/休息',
        description: '恢复或轻度交叉训练',
        guidance: '可选择游泳、骑车等低冲击运动，或完全休息。',
      ),
      WeeklyPlanDay(
        dayOfWeek: 5,
        type: 'easy',
        title: '轻松跑',
        description: '轻松跑步，保持节奏稳定',
        distanceKm: (adjustedMileage * 0.25).round(),
        guidance: '放松心态，以完成而非速度为目标。',
      ),
      WeeklyPlanDay(
        dayOfWeek: 6,
        type: 'rest',
        title: '休息',
        description: '为长跑做准备',
        guidance: '保证充足睡眠，补充水分。',
      ),
      WeeklyPlanDay(
        dayOfWeek: 7,
        type: 'long_run',
        title: '长距离跑',
        description: '本周最长距离，提升耐力',
        distanceKm: (adjustedMileage * 0.5).round(),
        guidance: '补给准备充足，前半程保守，后半程可适度加速。注意补水和补糖。',
      ),
    ];
    
    return WeeklyPlan(
      id: 'week_${DateTime.now().millisecondsSinceEpoch}',
      weekNumber: 1,
      days: days,
      createdAt: DateTime.now(),
    );
  }
}
