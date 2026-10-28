import '../entities/run_record.dart';
import '../entities/run_point.dart';

abstract class RunRepository {
  Future<RunRecord> startRun();
  Future<void> pauseRun(RunRecord record);
  Future<void> resumeRun(RunRecord record);
  Future<RunRecord> endRun(RunRecord record);
  Future<void> saveRunRecord(RunRecord record);
  Future<List<RunRecord>> getRunHistory();
  Future<RunRecord?> getRunRecord(int id);
  Future<void> addRunPoint(RunRecord record, RunPoint point);
  Future<double> calculateDistance(List<RunPoint> points);
  double calculatePace(double distanceMeters, int durationSeconds);
}
