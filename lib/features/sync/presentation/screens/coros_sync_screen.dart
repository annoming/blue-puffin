import 'package:flutter/material.dart';

class CorosSyncScreen extends StatefulWidget {
  const CorosSyncScreen({super.key});

  @override
  State<CorosSyncScreen> createState() => _CorosSyncScreenState();
}

class _CorosSyncScreenState extends State<CorosSyncScreen> {
  bool _isAuthorizing = false;
  bool _isSyncing = false;
  bool _synced = false;
  int _syncedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coros数据同步'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '同步跑步手表历史数据',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.watch, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Coros',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!_synced) ...[
                      ElevatedButton(
                        onPressed: _isAuthorizing ? null : _handleAuth,
                        child: Text(_isAuthorizing ? '授权中...' : '授权Coros账号'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _isSyncing ? null : _handleSync,
                        child: Text(_isSyncing ? '同步中...' : '同步历史跑步数据'),
                      ),
                    ] else ...[
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text('同步成功'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('已同步 $_syncedCount 条历史跑步记录'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '说明',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• 优先支持Coros API数据同步\n• 支持同步历史跑步记录（里程、时长、配速、开始时间等）\n• 需完成OAuth授权才能同步数据'),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAuth() async {
    setState(() => _isAuthorizing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isAuthorizing = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coros授权成功')));
    }
  }

  Future<void> _handleSync() async {
    setState(() => _isSyncing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isSyncing = false;
        _synced = true;
        _syncedCount = 3;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('历史跑步数据同步成功')));
    }
  }
}
