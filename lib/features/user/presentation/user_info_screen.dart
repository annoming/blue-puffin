import 'package:flutter/material.dart';
import '../../../core/storage/isar_service.dart';
import '../../auth/data/models/user_model.dart';
import '../../profile/data/models/profile_model.dart';
import '../../profile/data/profile_repository.dart';

class UserInfoScreen extends StatefulWidget {
  final int userId;
  const UserInfoScreen({super.key, required this.userId});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _profileRepository = ProfileRepository();
  UserModel? _user;
  ProfileModel? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() => _isLoading = true);
    try {
      final db = await IsarService.getInstance();
      final user = await db.userModels.get(widget.userId);
      final profile = await _profileRepository.getProfile(widget.userId);

      setState(() {
        _user = user;
        _profile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人信息'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '账号信息',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_user?.email != null)
                            _buildInfoRow('邮箱', _user!.email!),
                          if (_user?.phone != null)
                            _buildInfoRow('手机号', _user!.phone!),
                          _buildInfoRow(
                              '建档状态',
                              _user?.isProfileCompleted == true
                                  ? '已完成'
                                  : '未完成'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '建档信息',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (_profile == null)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('暂未填写建档信息'),
                      ),
                    )
                  else
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_profile!.currentWeeklyMileage != null)
                              _buildInfoRow('周跑量',
                                  '${_profile!.currentWeeklyMileage} km'),
                            if (_profile!.targetRaceType != null)
                              _buildInfoRow('目标赛事', _profile!.targetRaceType!),
                            if (_profile!.targetRaceTime != null)
                              _buildInfoRow(
                                  '目标完赛时间', _profile!.targetRaceTime!),
                            if (_profile!.availableTrainingDays != null)
                              _buildInfoRow(
                                  '可训练时间', _profile!.availableTrainingDays!),
                            if (_profile!.trainingGoal != null)
                              _buildInfoRow('训练目标', _profile!.trainingGoal!),
                            if (_profile!.injuryHistory != null &&
                                _profile!.injuryHistory!.isNotEmpty)
                              _buildInfoRow('伤病史', _profile!.injuryHistory!),
                            if (_profile!.dietaryPreferences != null &&
                                _profile!.dietaryPreferences!.isNotEmpty)
                              _buildInfoRow(
                                  '饮食偏好', _profile!.dietaryPreferences!),
                            if (_profile!.allergies != null &&
                                _profile!.allergies!.isNotEmpty)
                              _buildInfoRow('过敏史', _profile!.allergies!),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
