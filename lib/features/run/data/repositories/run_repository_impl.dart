import '../../domain/entities/run_record.dart';
import '../../domain/entities/run_point.dart';
import '../../domain/repositories/run_repository.dart';
import 'dart:math' as math;

class RunRepositoryImpl implements RunRepository {
  @override
  Future<RunRecord> startRun() async {
    final record = RunRecord();
    record.startTime = DateTime.now();
    record.isPaused = false;
    return record;
  }

  @override
  Future<void> pauseRun(RunRecord record) async {
    if (!record.isPaused) {
      record.isPaused = true;
      final pause = RunPause();
      pause.startPause = DateTime.now();
      record.pauses.add(pause);
    }
  }

  @override
  Future<void> resumeRun(RunRecord record) async {
    if (record.isPaused && record.pauses.isNotEmpty) {
      record.isPaused = false;
      final lastPause = record.pauses.last;
      lastPause.endPause = DateTime.now();
    }
  }

  @override
  Future<RunRecord> endRun(RunRecord record) async {
    record.endTime = DateTime.now();
    record.isPaused = false;
    if (record.pauses.isNotEmpty) {
      final lastPause = record.pauses.last;
      if (lastPause.endPause == null) {
        lastPause.endPause = DateTime.now();
      }
    }
    record.duration = record.endTime!.difference(record.startTime).inSeconds;
    // Subtract pause time
    int pauseDuration = 0;
    for (var pause in record.pauses) {
      if (pause.startPause != null && pause.endPause != null) {
        pauseDuration += pause.endPause!.difference(pause.startPause!).inSeconds;
      }
    }
    record.duration = record.duration - pauseDuration;
    if (record.duration < 0) record.duration = 0;
    if (record.distance > 0) {
      record.avgPace = calculatePace(record.distance, record.duration);
    }
    return record;
  }

  @override
  Future<void> saveRunRecord(RunRecord record) async {
    // TODO: Implement with Isar
  }

  @override
  Future<List<RunRecord>> getRunHistory() async {
    return [];
  }

  @override
  Future<RunRecord?> getRunRecord(int id) async {
    return null;
  }

  @override
  Future<void> addRunPoint(RunRecord record, RunPoint point) async {
    record.latitudes.add(point.latitude);
    record.longitudes.add(point.longitude);
    record.timestamps.add(point.timestamp);
  }

  @override
  Future<double> calculateDistance(List<RunPoint> points) async {
    if (points.length < 2) return 0.0;
    double totalDistance = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      totalDistance += _calculateDistanceBetween(
        points[i].latitude,
        points[i].longitude,
        points[i + 1].latitude,
        points[i + 1].longitude,
      );
    }
    return totalDistance;
  }

  double _calculateDistanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // meters
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }

  @override
  double calculatePace(double distanceMeters, int durationSeconds) {
    if (distanceMeters <= 0) return 0.0;
    // pace in seconds per km
    return (durationSeconds / (distanceMeters / 1000));
  }
}
