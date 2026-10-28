class RunRecord {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final double distanceKm;
  final int durationSeconds;
  final String? trainingTaskId;
  final bool associatedWithTraining;

  const RunRecord({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.distanceKm,
    required this.durationSeconds,
    this.trainingTaskId,
    this.associatedWithTraining = false,
  });

  RunRecord copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    double? distanceKm,
    int? durationSeconds,
    String? trainingTaskId,
    bool? associatedWithTraining,
  }) {
    return RunRecord(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distanceKm: distanceKm ?? this.distanceKm,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      trainingTaskId: trainingTaskId ?? this.trainingTaskId,
      associatedWithTraining: associatedWithTraining ?? this.associatedWithTraining,
    );
  }
}
