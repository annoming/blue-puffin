import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/training_plan_service.dart';

class WeeklyPlanScreen extends ConsumerWidget {
  const WeeklyPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planService = TrainingPlanService();
    final plan = planService.generateWeeklyPlan(syncedRunsCount: 3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('个性化训练计划'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '本周训练计划（规则版）',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '基于建档信息和历史跑步数据生成',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...plan.days.map((day) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '周${day.dayOfWeek}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(_getTypeText(day.type)),
                              backgroundColor: _getTypeColor(day.type),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          day.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(day.description),
                        if (day.distanceKm != null) ...[
                          const SizedBox(height: 4),
                          Text('距离: ${day.distanceKm}公里${day.durationMin != null ? " | 时间: ${day.durationMin}分钟" : ""}'),
                        ],
                        if (day.guidance != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '提示：${day.guidance}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'easy':
        return '轻松跑';
      case 'tempo':
        return '节奏跑';
      case 'long_run':
        return '长距离';
      case 'interval':
        return '间歇跑';
      case 'rest':
        return '休息';
      default:
        return type;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'easy':
        return Colors.green.shade100;
      case 'tempo':
        return Colors.orange.shade100;
      case 'long_run':
        return Colors.red.shade100;
      case 'interval':
        return Colors.purple.shade100;
      case 'rest':
        return Colors.grey.shade200;
      default:
        return Colors.grey.shade100;
    }
  }
}
