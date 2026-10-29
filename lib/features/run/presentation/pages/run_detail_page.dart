import 'package:flutter/material.dart';
import '../../data/models/run_record_model.dart';
import '../utils/run_formatters.dart';

class RunDetailPage extends StatelessWidget {
  final RunRecordModel record;
  const RunDetailPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final date = record.startTime.toLocal();
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('跑步详情'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateStr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text('里程: ${RunFormatters.formatDistanceKm(record.distanceMeters)} km', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text('时长: ${RunFormatters.formatDuration(record.durationSeconds)}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text('配速: ${RunFormatters.formatPace(record.distanceMeters, record.durationSeconds)} /km', style: const TextStyle(fontSize: 20)),
            if (record.title != null) ...[
              const SizedBox(height: 12),
              Text('关联训练: ${record.title}', style: const TextStyle(fontSize: 16)),
            ],
          ],
        ),
      ),
    );
  }
}
