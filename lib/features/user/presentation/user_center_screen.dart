import 'package:flutter/material.dart';
import '../../../core/storage/isar_service.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/presentation/auth_screen.dart';
import '../data/user_profile_repository.dart';
import '../data/models/user_profile_model.dart';
import 'user_profile_edit_screen.dart';

class UserCenterScreen extends StatefulWidget {
  final int userId;
  const UserCenterScreen({super.key, required this.userId});

  @override
  State<UserCenterScreen> createState() => _UserCenterScreenState();
}

class _UserCenterScreenState extends State<UserCenterScreen> {
  final _userProfileRepository = UserProfileRepository();
  UserModel? _user;
  UserProfileModel? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final db = await IsarService.getInstance();
      final user = await db.userModels.get(widget.userId);
      final profile = await _userProfileRepository.getProfile(widget.userId);
      setState(() {
        _user = user;
        _profile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人中心')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('账号信息（本地模式）', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          if (_user?.email != null) _buildRow('邮箱', _user!.email!),
                          if (_user?.phone != null) _buildRow('手机号', _user!.phone!),
                          _buildRow('登录态', '已登录（本地保持）'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('建档信息（真实数据）', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          if (_profile == null)
                            const Text('暂未建档')
                          else ...[
                            if (_profile!.height != null) _buildRow('身高', '${_profile!.height} cm'),
                            if (_profile!.weight != null) _buildRow('体重', '${_profile!.weight} kg'),
                            if (_profile!.age != null) _buildRow('年龄', '${_profile!.age}'),
                            if (_profile!.gender != null) _buildRow('性别', _profile!.gender!),
                            if (_profile!.goal != null) _buildRow('目标', _profile!.goal!),
                            if (_profile!.trainingLevel != null) _buildRow('训练水平', _profile!.trainingLevel!),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.edit),
                          title: const Text('编辑建档信息'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => UserProfileEditScreen(userId: widget.userId)),
                            ).then((_) => _loadData());
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.history),
                          title: const Text('跑步历史'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).pushNamed('/run/history');
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text('退出登录'),
                          onTap: _logout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value),
        ],
      ),
    );
  }
}
