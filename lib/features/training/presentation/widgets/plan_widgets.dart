import 'package:flutter/material.dart';

import '../../domain/models/training_task.dart';
import '../../../plan/domain/models/training_plan.dart';

String planTypeLabel(String type) {
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

Color planTypeColor(String type) {
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

Color taskStatusColor(TrainingTaskStatus status) {
  switch (status) {
    case TrainingTaskStatus.completed:
      return Colors.green.shade100;
    case TrainingTaskStatus.skipped:
      return Colors.orange.shade100;
    case TrainingTaskStatus.pending:
      return Colors.blueGrey.shade50;
  }
}

Widget taskStatusChip(TrainingTask? task) {
  if (task == null) return const SizedBox.shrink();
  return Chip(
    label: Text(task.status.label),
    backgroundColor: taskStatusColor(task.status),
    side: BorderSide.none,
    visualDensity: VisualDensity.compact,
  );
}

String sessionTypeLabel(PlanSessionType type) => type.label;

String sessionTypeCode(PlanSessionType type) => type.code;

String sessionDateLabel(DateTime date) {
  final String weekday = weekdayLabels[date.weekday - 1];
  return '$weekday ${formatPlanDate(date)}';
}
