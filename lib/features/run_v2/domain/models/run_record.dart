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
}
