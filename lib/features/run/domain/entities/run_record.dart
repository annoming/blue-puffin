import 'package:isar/isar.dart';

part 'run_record.g.dart';

@collection
class RunRecordEntity {
  Id id = Isar.autoIncrement;

  @Index()
  DateTime startTime = DateTime.now();

  DateTime? endTime;

  double distance = 0.0; // in meters
  int duration = 0; // in seconds
  double avgPace = 0.0; // seconds per km
  double? maxPace;
  double? avgHeartRate;
  double? maxHeartRate;

  List<double> latitudes = [];
  List<double> longitudes = [];
  List<DateTime> timestamps = [];

  bool isPaused = false;
  List<RunPauseEmbedded> pauses = [];

  String? trainingTaskId;
  bool associatedWithTraining = false;
}

@embedded
class RunPauseEmbedded {
  DateTime? startPause;
  DateTime? endPause;
}
