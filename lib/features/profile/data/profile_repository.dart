import 'package:isar/isar.dart';
import '../data/models/profile_model.dart';
import '../../../core/storage/isar_service.dart';

class ProfileRepository {
  Future<Isar> get _db async => await IsarService.getInstance();

  Future<ProfileModel> saveProfile({
    required int userId,
    double? currentWeeklyMileage,
    String? targetRaceTime,
    String? targetRaceType,
    String? availableTrainingDays,
    String? injuryHistory,
    String? dietaryPreferences,
    String? allergies,
    String? trainingGoal,
  }) async {
    final db = await _db;
    ProfileModel? existing = await db.profileModels
        .filter()
        .userIdEqualTo(userId)
        .findFirst();

    if (existing != null) {
      existing
        ..currentWeeklyMileage = currentWeeklyMileage
        ..targetRaceTime = targetRaceTime
        ..targetRaceType = targetRaceType
        ..availableTrainingDays = availableTrainingDays
        ..injuryHistory = injuryHistory
        ..dietaryPreferences = dietaryPreferences
        ..allergies = allergies
        ..trainingGoal = trainingGoal
        ..updatedAt = DateTime.now();

      await db.writeTxn(() async {
        await db.profileModels.put(existing);
      });
      return existing;
    } else {
      final profile = ProfileModel()
        ..userId = userId
        ..currentWeeklyMileage = currentWeeklyMileage
        ..targetRaceTime = targetRaceTime
        ..targetRaceType = targetRaceType
        ..availableTrainingDays = availableTrainingDays
        ..injuryHistory = injuryHistory
        ..dietaryPreferences = dietaryPreferences
        ..allergies = allergies
        ..trainingGoal = trainingGoal
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      await db.writeTxn(() async {
        await db.profileModels.put(profile);
      });
      return profile;
    }
  }

  Future<ProfileModel?> getProfile(int userId) async {
    final db = await _db;
    return await db.profileModels.filter().userIdEqualTo(userId).findFirst();
  }
}
