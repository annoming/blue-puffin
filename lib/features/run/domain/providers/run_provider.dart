import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/run_record.dart';

final runRecordsProvider = StateNotifierProvider<RunRecordsNotifier, List<RunRecord>>((ref) {
  return RunRecordsNotifier();
});

class RunRecordsNotifier extends StateNotifier<List<RunRecord>> {
  RunRecordsNotifier() : super([]);

  String startRun({String? trainingTaskId}) {
    final id = 'run_${DateTime.now().millisecondsSinceEpoch}';
    final record = RunRecord(
      id: id,
      startTime: DateTime.now(),
      distanceKm: 0.0,
      durationSeconds: 0,
      trainingTaskId: trainingTaskId,
      associatedWithTraining: trainingTaskId != null,
    );
    return id;
  }

  void completeRun(String runId, {String? trainingTaskId}) {
    // Not used - real tracking handled by RunNotifier
  }
}
