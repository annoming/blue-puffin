import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/permissions/permission_service.dart';
import '../../../../core/storage/isar_service.dart';
import '../../../training/domain/providers/training_provider.dart';
import '../../data/models/run_record_model.dart';
import '../utils/run_formatters.dart';

class RunScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? extra;
  const RunScreen({super.key, this.extra});

  @override
  ConsumerState<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends ConsumerState<RunScreen> {
  final LocationService _locationService = LocationService();
  final PermissionService _permissionService = PermissionService();
  StreamSubscription? _positionSubscription;
  Timer? _timer;
  bool isRunning = false;
  bool isPaused = false;
  String? runId;
  DateTime? startTime;
  int durationSeconds = 0;
  double distanceMeters = 0.0;
  List<double> latitudes = [];
  List<double> longitudes = [];

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) => RunFormatters.formatDuration(seconds);

  String _formatDistance(double meters) => '${RunFormatters.formatDistanceKm(meters)} 公里';

  String _formatPace() => RunFormatters.formatPace(distanceMeters, durationSeconds);

  Future<void> _startRun() async {
    final granted = await _permissionService.requestAllRunPermissions();
    if (!granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要定位权限才能记录跑步轨迹')),
        );
      }
      return;
    }

    setState(() {
      isRunning = true;
      isPaused = false;
      durationSeconds = 0;
      distanceMeters = 0.0;
      latitudes = [];
      longitudes = [];
      startTime = DateTime.now();
      runId = 'run_${DateTime.now().millisecondsSinceEpoch}';
    });

    _startTimer();
    _startLocationTracking();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isRunning && !isPaused && mounted) {
        setState(() {
          durationSeconds++;
        });
      }
    });
  }

  void _startLocationTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = _locationService.getPositionStream().listen((position) {
      if (isRunning && !isPaused && mounted) {
        if (position.accuracy > 20) return;
        setState(() {
          latitudes.add(position.latitude);
          longitudes.add(position.longitude);
          _updateDistance();
        });
      }
    });
  }

  void _updateDistance() {
    if (latitudes.length >= 2) {
      double totalDistance = 0.0;
      for (int i = 0; i < latitudes.length - 1; i++) {
        totalDistance += _calculateDistance(
          latitudes[i], longitudes[i],
          latitudes[i + 1], longitudes[i + 1],
        );
      }
      setState(() {
        distanceMeters = totalDistance;
      });
    }
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000;
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }

  void _pauseRun() {
    setState(() {
      isPaused = true;
    });
  }

  void _resumeRun() {
    setState(() {
      isPaused = false;
    });
  }

  Future<void> _endRun() async {
    final fromTraining = widget.extra?['fromTraining'] == true;
    final taskId = widget.extra?['taskId'] as String?;
    final taskTitle = widget.extra?['taskTitle'] as String?;

    _timer?.cancel();
    _positionSubscription?.cancel();

    setState(() {
      isRunning = false;
      isPaused = false;
    });

    try {
      final isar = await IsarService.getInstance();
      final record = RunRecordModel()
        ..source = 'local'
        ..externalId = runId ?? 'run_${DateTime.now().millisecondsSinceEpoch}'
        ..startTime = startTime ?? DateTime.now()
        ..durationSeconds = durationSeconds
        ..distanceMeters = distanceMeters
        ..title = fromTraining ? taskTitle : null
        ..syncedAt = DateTime.now()
        ..createdAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.runRecordModels.put(record);
      });
      if (fromTraining && taskId != null) {
        ref.read(trainingTasksProvider.notifier).markCompleted(runId ?? record.externalId, taskId);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存失败')),
        );
      }
    }

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('跑步完成'),
          content: Text('里程: ${_formatDistance(distanceMeters)}\n时长: ${_formatDuration(durationSeconds)}\n配速: ${_formatPace()} /km\n轨迹点: ${latitudes.length}'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.go('/');
              },
              child: const Text('确定'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fromTraining = widget.extra?['fromTraining'] == true;
    final taskId = widget.extra?['taskId'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(fromTraining && taskId != null ? '训练关联跑步' : '跑步'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fromTraining && taskId != null) ...[
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text(
                        '计划关联跑步',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('训练任务: $taskId'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              _formatDuration(durationSeconds),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _formatDistance(distanceMeters),
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              '配速: ${_formatPace()} /km',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            if (!isRunning)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startRun,
                  child: const Text('开始跑步'),
                ),
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!isPaused)
                        ElevatedButton(
                          onPressed: _pauseRun,
                          child: const Text('暂停'),
                        )
                      else
                        ElevatedButton(
                          onPressed: _resumeRun,
                          child: const Text('继续'),
                        ),
                      ElevatedButton(
                        onPressed: _endRun,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        child: const Text('结束跑步'),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
