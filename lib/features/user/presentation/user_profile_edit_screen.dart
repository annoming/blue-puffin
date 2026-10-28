import 'package:flutter/material.dart';
import '../data/user_profile_repository.dart';

class UserProfileEditScreen extends StatefulWidget {
  final int userId;
  const UserProfileEditScreen({super.key, required this.userId});

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userProfileRepository = UserProfileRepository();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  String _gender = '男';
  String _goal = '5K';
  String _trainingLevel = '初学';

  bool _isLoading = false;

  final List<String> _goalOptions = ['5K', '10K', '半马', '全马', '其他'];
  final List<String> _levelOptions = ['初学', '入门', '进阶', '高级'];
  final List<String> _genderOptions = ['男', '女', '其他'];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _userProfileRepository.getProfile(widget.userId);
      if (profile != null) {
        setState(() {
          if (profile.height != null) _heightController.text = profile.height.toString();
          if (profile.weight != null) _weightController.text = profile.weight.toString();
          if (profile.age != null) _ageController.text = profile.age.toString();
          if (profile.gender != null) _gender = profile.gender!;
          if (profile.goal != null) _goal = profile.goal!;
          if (profile.trainingLevel != null) _trainingLevel = profile.trainingLevel!;
        });
      }
    } catch (e) {
      // ignore
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      double? height;
      double? weight;
      int? age;
      if (_heightController.text.isNotEmpty) height = double.tryParse(_heightController.text);
      if (_weightController.text.isNotEmpty) weight = double.tryParse(_weightController.text);
      if (_ageController.text.isNotEmpty) age = int.tryParse(_ageController.text);

      await _userProfileRepository.saveProfile(
        userId: widget.userId,
        height: height,
        weight: weight,
        age: age,
        gender: _gender,
        goal: _goal,
        trainingLevel: _trainingLevel,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('建档信息已保存')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('保存失败: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户建档（本地存储）')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('身高/体重/年龄/性别/目标/训练水平', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('数据仅保存在本地，支持编辑和持久化'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: '身高（cm）', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: '体重（kg）', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: '年龄', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(labelText: '性别', border: OutlineInputBorder()),
                items: _genderOptions.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (v) => setState(() => _gender = v ?? '男'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _goal,
                decoration: const InputDecoration(labelText: '目标（5K/10K/半马/全马）', border: OutlineInputBorder()),
                items: _goalOptions.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (v) => setState(() => _goal = v ?? '5K'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _trainingLevel,
                decoration: const InputDecoration(labelText: '训练水平', border: OutlineInputBorder()),
                items: _levelOptions.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                onChanged: (v) => setState(() => _trainingLevel = v ?? '初学'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  child: _isLoading ? const CircularProgressIndicator() : const Text('保存建档'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
