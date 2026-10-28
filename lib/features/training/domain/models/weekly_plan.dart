class WeeklyPlan {
  final String id;
  final int weekNumber;
  final List<WeeklyPlanDay> days;
  final DateTime createdAt;

  const WeeklyPlan({
    required this.id,
    required this.weekNumber,
    required this.days,
    required this.createdAt,
  });
}

class WeeklyPlanDay {
  final int dayOfWeek; // 1-7
  final String type; // rest, easy, tempo, long_run, interval
  final String title;
  final String description;
  final int? distanceKm;
  final int? durationMin;
  final String? guidance;

  const WeeklyPlanDay({
    required this.dayOfWeek,
    required this.type,
    required this.title,
    required this.description,
    this.distanceKm,
    this.durationMin,
    this.guidance,
  });
}
