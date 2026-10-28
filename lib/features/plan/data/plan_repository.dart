import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/training_plan.dart';

/// 周计划的本地持久化（SharedPreferences + JSON）。
class PlanRepository {
  static const String _planKey = 'training_plan_v1';

  Future<TrainingPlan?> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_planKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final Map<String, dynamic> json =
          jsonDecode(raw) as Map<String, dynamic>;
      return TrainingPlan.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(TrainingPlan plan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_planKey, jsonEncode(plan.toJson()));
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_planKey);
  }
}
