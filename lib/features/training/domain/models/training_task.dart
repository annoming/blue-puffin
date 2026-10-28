class TrainingTask {
  final String id;
  final String title;
  final String type;
  final int? distanceKm;
  final int? durationMin;
  final String description;
  final bool completed;
  final String? guidance;

  const TrainingTask({
    required this.id,
    required this.title,
    required this.type,
    this.distanceKm,
    this.durationMin,
    required this.description,
    this.completed = false,
    this.guidance,
  });

  TrainingTask copyWith({
    String? id,
    String? title,
    String? type,
    int? distanceKm,
    int? durationMin,
    String? description,
    bool? completed,
    String? guidance,
  }) {
    return TrainingTask(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMin: durationMin ?? this.durationMin,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      guidance: guidance ?? this.guidance,
    );
  }
}
