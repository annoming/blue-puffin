import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/data/auth_repository.dart';
import '../../data/profile_repository.dart';
import '../../../auth/data/models/user_model.dart';

class ProfileFormScreen extends ConsumerStatefulWidget {
  const ProfileFormScreen({super.key});

  @override
  ConsumerState<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends ConsumerState<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _weeklyMileageController = TextEditingController();
  final _targetRaceTimeController = TextEditingController();
  final _targetRaceTypeController = TextEditingController();
  final _availableDaysController = TextEditingController();
  final _injuryHistoryController = TextEditingController();
  final _dietaryController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _goalController = TextEditingController();

  bool _isRegistering = true;
  UserModel? _currentUser;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _weeklyMileageController.dispose();
    _targetRaceTimeController.dispose();
    _targetRaceTypeController.dispose();
    _availableDaysController.dispose();
    _injuryHistoryController.dispose();
    _dietaryController.dispose();
    _allergiesController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentUser == null ? (_isRegistering ? '注册并建档' : '登录') : '完善建档信息'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_currentUser == null) ...[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: '邮箱'),
                  validator: (v) => v?.isEmpty == true ? '请输入邮箱' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: '密码'),
                  obscureText: true,
                  validator: (v) => v?.isEmpty == true ? '请输入密码' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setState(() => _isRegistering = !_isRegistering),
                      child: Text(_isRegistering ? '已有账号？登录' : '没有账号？注册'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _handleAuth,
                  child: Text(_isRegistering ? '注册' : '登录'),
                ),
                const SizedBox(height: 24),
              ],
              if (_currentUser != null) ...[
                const Text(
                  '建档信息',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _weeklyMileageController,
                  decoration: const InputDecoration(labelText: '当前周跑量（公里）'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _targetRaceTypeController,
                  decoration: const InputDecoration(labelText: '目标比赛（如：全程马拉松、半程马拉松）'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _targetRaceTimeController,
                  decoration: const InputDecoration(labelText: '目标完赛时间（如：3:30:00）'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _availableDaysController,
                  decoration: const InputDecoration(labelText: '可训练时间（如：每周3-4天）'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _injuryHistoryController,
                  decoration: const InputDecoration(labelText: '伤病史'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _dietaryController,
                  decoration: const InputDecoration(labelText: '饮食偏好'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _allergiesController,
                  decoration: const InputDecoration(labelText: '过敏史'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _goalController,
                  decoration: const InputDecoration(labelText: '训练目标'),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('提交建档信息'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    final authRepo = AuthRepository();
    try {
      if (_isRegistering) {
        final user = await authRepo.registerWithEmail(_emailController.text, _passwordController.text);
        setState(() => _currentUser = user);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('注册成功，请完善建档信息')));
        }
      } else {
        final user = await authRepo.login(_emailController.text, _passwordController.text);
        setState(() => _currentUser = user);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('登录成功')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('错误: $e')));
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_currentUser == null) return;
    final profileRepo = ProfileRepository();
    try {
      double? mileage;
      if (_weeklyMileageController.text.isNotEmpty) {
        mileage = double.tryParse(_weeklyMileageController.text);
      }
      await profileRepo.saveProfile(
        userId: _currentUser!.id,
        currentWeeklyMileage: mileage,
        targetRaceTime: _targetRaceTimeController.text,
        targetRaceType: _targetRaceTypeController.text,
        availableTrainingDays: _availableDaysController.text,
        injuryHistory: _injuryHistoryController.text,
        dietaryPreferences: _dietaryController.text,
        allergies: _allergiesController.text,
        trainingGoal: _goalController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('建档信息提交成功')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('错误: $e')));
      }
    }
  }
}
