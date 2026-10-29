import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../../../core/storage/isar_service.dart';
import '../../data/models/run_record_model.dart';
import '../utils/run_formatters.dart';
import 'run_detail_page.dart';

class RunHistoryPage extends StatefulWidget {
  const RunHistoryPage({super.key});

  @override
  State<RunHistoryPage> createState() => _RunHistoryPageState();
}

class _RunHistoryPageState extends State<RunHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('跑步记录'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Isar>(
        future: IsarService.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final db = snapshot.data!;
          return StreamBuilder<List<RunRecordModel>>(
            stream: db.runRecordModels.where().watch(fireImmediately: true),
            builder: (context, streamSnapshot) {
              final records = streamSnapshot.data ?? [];
              if (records.isEmpty) {
                return const Center(
                  child: Text(
                    '暂无跑步记录',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              final sorted = List<RunRecordModel>.from(records)
                ..sort((a, b) => b.startTime.compareTo(a.startTime));
              return ListView.builder(
                itemCount: sorted.length,
                itemBuilder: (context, index) {
                  final record = sorted[index];
                  final date = record.startTime.toLocal();
                  final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                  return ListTile(
                    title: Text(dateStr),
                    subtitle: Text('距离: ${RunFormatters.formatDistanceKm(record.distanceMeters)} km  时长: ${RunFormatters.formatDuration(record.durationSeconds)}  配速: ${RunFormatters.formatPace(record.distanceMeters, record.durationSeconds)} /km'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RunDetailPage(record: record),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
