import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('步凡'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '首页',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.directions_run, color: Colors.blue),
                title: const Text('今日训练'),
                subtitle: const Text('查看今日训练计划，开始训练'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/training/today');
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.run_circle, color: Colors.green),
                title: const Text('开始跑步'),
                subtitle: const Text('自由跑步记录'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/run');
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.orange),
                title: const Text('用户建档'),
                subtitle: const Text('完善个人信息和训练目标'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/profile');
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.sync, color: Colors.purple),
                title: const Text('Coros同步'),
                subtitle: const Text('同步跑步手表数据'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/sync/coros');
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month, color: Colors.red),
                title: const Text('训练计划'),
                subtitle: const Text('查看个性化周训练计划'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push('/training/plan');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
