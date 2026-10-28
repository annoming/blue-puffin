import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/run_record.dart';
import '../../domain/entities/run_point.dart';
import '../../data/repositories/run_repository_impl.dart';
import '../../../../core/services/location_service.dart';

class RunState {
  final RunRecord? currentRun;
  final bool isRunning;
  final bool isPaused;
  final List<RunPoint> points;
  final double distance; // meters
  final int duration; // seconds
  final double pace; // seconds per km
  final StreamSubscription? positionSubscription;

  const RunState({
    this.currentRun,
    this.isRunning = false,
    this.isPaused = false,
    this.points = const [],
    this.distance = 0.0,
    this.duration = 0,
    this.pace = 0.0,
    this.positionSubscription,
  });

  RunState copyWith({
    RunRecord? currentRun,
    bool? isRunning,
    bool? isPaused,
    List<RunPoint>? points,
    double? distance,
    int? duration,
    double? pace,
    StreamSubscription? positionSubscription,
  }) {
    return RunState(
      currentRun: currentRun ?? this.currentRun,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      points: points ?? this.points,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      pace: pace ?? this.pace,
      positionSubscription: positionSubscription ?? this.positionSubscription,
    );
  }
}

class RunNotifier extends StateNotifier<RunState> {
  final RunRepositoryImpl _repository = RunRepositoryImpl();
  final LocationService _locationService = LocationService();
  Timer? _timer;

  RunNotifier() : super(const RunState());

  Future<void> startRun() async {
    final record = await _repository.startRun();
    state = state.copyWith(
      currentRun: record,
      isRunning: true,
      isPaused: false,
      points: [],
      distance: 0.0,
      duration: 0,
      pace: 0.0,
    );

    _startTimer();
    _startLocationTracking();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isRunning && !state.isPaused) {
        state = state.copyWith(duration: state.duration + 1);
        if (state.distance > 0) {
          state = state.copyWith(pace: _repository.calculatePace(state.distance, state.duration));
        }
      }
    });
  }

  void _startLocationTracking() {
    final subscription = _locationService.getPositionStream().listen((position) {
      if (state.isRunning && !state.isPaused) {
        final point = RunPoint(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
          accuracy: position.accuracy,
          speed: position.speed,
        );
        final newPoints = List<RunPoint>.from(state.points)..add(point);
        state = state.copyWith(points: newPoints);
        _updateDistance();
      }
    });
    state = state.copyWith(positionSubscription: subscription);
  }

  Future<void> _updateDistance() async {
    if (state.points.length >= 2) {
      final distance = await _repository.calculateDistance(state.points);
      state = state.copyWith(distance: distance);
      if (state.duration > 0) {
        state = state.copyWith(pace: _repository.calculatePace(distance, state.duration));
      }
    }
  }

  Future<void> pauseRun() async {
    if (state.currentRun != null) {
      await _repository.pauseRun(state.currentRun!);
      state = state.copyWith(isPaused: true);
    }
  }

  Future<void> resumeRun() async {
    if (state.currentRun != null) {
      await _repository.resumeRun(state.currentRun!);
      state = state.copyWith(isPaused: false);
    }
  }

  Future<RunRecord?> endRun() async {
    if (state.currentRun != null) {
      state.currentRun!.distance = state.distance;
      final record = await _repository.endRun(state.currentRun!);
      await _repository.saveRunRecord(record);
      _timer?.cancel();
      state.positionSubscription?.cancel();
      state = const RunState();
      return record;
    }
    return null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    state.positionSubscription?.cancel();
    super.dispose();
  }
}

final runProvider = StateNotifierProvider<RunNotifier, RunState>((ref) {
  return RunNotifier();
});
