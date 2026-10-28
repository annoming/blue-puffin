import 'package:flutter/material.dart';
import '../data/profile_repository.dart';
import '../../../core/storage/isar_service.dart';
import '../../auth/data/models/user_model.dart';

class ProfileFormScreen extends StatefulWidget {
  final int userId;
  const ProfileFormScreen({super.key, required this.userId});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profileRepository = ProfileRepository();

  final _currentMileageController = TextEditingController();
  final _targetRaceTimeController = TextEditingController();
  final _targetRaceTypeController = TextEditingController();
  final _availableTrainingDaysController = TextEditingController();
  final _injuryHistoryController = TextEditingController();
  final _dietaryPreferencesController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _trainingGoalController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _currentMileageController.dispose();
    _targetRaceTimeController.dispose();
    _targetRaceTypeController.dispose();
    _availableTrainingDaysController.dispose();
    _injuryHistoryController.dispose();
    _dietaryPreferencesController.dispose();
    _allergiesController.dispose();
    _trainingGoalController.dispose();
    super.dispose();
  }

  Future<void> _submitProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      double? mileage;
      if (_currentMileageController.text.isNotEmpty) {
        mileage = double.tryParse(_currentMileageController.text);
      }

      await _profileRepository.saveProfile(
        userId: widget.userId,
        currentWeeklyMileage: mileage,
        targetRaceTime: _targetRaceTimeController.text.isEmpty
            ? null
            : _targetRaceTimeController.text,
        targetRaceType: _targetRaceTypeController.text.isEmpty
            ? null
            : _targetRaceTypeController.text,
        availableTrainingDays: _availableTrainingDaysController.text.isEmpty
            ? null
            : _availableTrainingDaysController.text,
        injuryHistory: _injuryHistoryController.text.isEmpty
            ? null
            : _injuryHistoryController.text,
        dietaryPreferences: _dietaryPreferencesController.text.isEmpty
            ? null
            : _dietaryPreferencesController.text,
        allergies: _allergiesController.text.isEmpty
            ? null
            : _allergiesController.text,
        trainingGoal: _trainingGoalController.text.isEmpty
            ? null
            : _trainingGoalController.text,
      );

      // Mark user profile as completed
      final db = await IsarService.getInstance();
      final user = await db.userModels.get(widget.userId);
      if (user != null) {
        user.isProfileCompleted = true;
        user.updatedAt = DateTime.now();
        await db.writeTxn(() async {
          await db.userModels.put(user);
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('建档成功！')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileSuccessScreen(userId: widget.userId),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户建档'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '请填写您的跑步信息，帮助我们为您定制训练计划',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _currentMileageController,
                decoration: const InputDecoration(
                  labelText: '当前周跑量（公里）',
                  hintText: '例如：20',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _targetRaceTypeController,
                decoration: const InputDecoration(
                  labelText: '目标赛事类型',
                  hintText: '例如：全程马拉松、半程马拉松、10公里',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _targetRaceTimeController,
                decoration: const InputDecoration(
                  labelText: '目标完赛时间',
                  hintText: '例如：3:30:00',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _availableTrainingDaysController,
                decoration: const InputDecoration(
                  labelText: '可训练时间/天数',
                  hintText: '例如：每周3-4天，早晚各1小时',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _injuryHistoryController,
                decoration: const InputDecoration(
                  labelText: '伤病史',
                  hintText: '如有旧伤或需要注意的部位，请说明',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dietaryPreferencesController,
                decoration: const InputDecoration(
                  labelText: '饮食偏好',
                  hintText: '例如：素食、低碳水、均衡等',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: '过敏史',
                  hintText: '如有食物过敏等，请说明',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _trainingGoalController,
                decoration: const InputDecoration(
                  labelText: '训练目标',
                  hintText: '例如：首次完成马拉松、破PB等',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitProfile,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('提交建档'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSuccessScreen extends StatelessWidget {
  final int userId;
  const ProfileSuccessScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('建档成功'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              '建档信息已保存！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '您的个性化跑步计划即将生成',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}
