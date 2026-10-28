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
    // 简化处理，实际场景中会在运行时更新
    return id;
  }

  void completeRun(String runId, {String? trainingTaskId}) {
    final record = RunRecord(
      id: runId,
      startTime: DateTime.now().subtract(const Duration(minutes: 35)),
      endTime: DateTime.now(),
      distanceKm: 5.0,
      durationSeconds: 2100,
      trainingTaskId: trainingTaskId,
      associatedWithTraining: trainingTaskId != null,
    );
    state = [...state, record];
  }
}
