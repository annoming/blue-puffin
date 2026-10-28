import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/run_provider.dart';

class RunPage extends ConsumerWidget {
  const RunPage({super.key});

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(2)} km';
    }
    return '${meters.toStringAsFixed(0)} m';
  }

  String _formatPace(double secondsPerKm) {
    if (secondsPerKm <= 0 || secondsPerKm.isInfinite) {
      return '--:--';
    }
    int minutes = secondsPerKm ~/ 60;
    int seconds = (secondsPerKm % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} /km';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runState = ref.watch(runProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('跑步'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  '轨迹地图',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          _formatDistance(runState.distance),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('里程', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _formatDuration(runState.duration),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('时长', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _formatPace(runState.pace),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('配速', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (!runState.isRunning)
                  ElevatedButton(
                    onPressed: () {
                      ref.read(runProvider.notifier).startRun();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 16,
                      ),
                      shape: const CircleBorder(),
                    ),
                    child: const Text(
                      '开始',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!runState.isPaused)
                        ElevatedButton(
                          onPressed: () {
                            ref.read(runProvider.notifier).pauseRun();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('暂停', style: TextStyle(fontSize: 18)),
                        )
                      else
                        ElevatedButton(
                          onPressed: () {
                            ref.read(runProvider.notifier).resumeRun();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('继续', style: TextStyle(fontSize: 18)),
                        ),
                      ElevatedButton(
                        onPressed: () async {
                          final record = await ref.read(runProvider.notifier).endRun();
                          if (context.mounted && record != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '跑步完成！里程: ${_formatDistance(record.distance)}, 时长: ${_formatDuration(record.duration)}',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('结束', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
