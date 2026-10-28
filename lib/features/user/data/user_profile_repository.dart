import 'package:isar/isar.dart';
import '../../../core/storage/isar_service.dart';
import 'models/user_profile_model.dart';

class UserProfileRepository {
  Future<Isar> get _db async => await IsarService.getInstance();

  Future<UserProfileModel> saveProfile({
    required int userId,
    double? height,
    double? weight,
    int? age,
    String? gender,
    String? goal,
    String? trainingLevel,
  }) async {
    final db = await _db;
    UserProfileModel? existing = await db.userProfileModels
        .filter()
        .userIdEqualTo(userId)
        .findFirst();

    if (existing != null) {
      existing
        ..height = height
        ..weight = weight
        ..age = age
        ..gender = gender
        ..goal = goal
        ..trainingLevel = trainingLevel
        ..updatedAt = DateTime.now();

      await db.writeTxn(() async {
        await db.userProfileModels.put(existing);
      });
      return existing;
    } else {
      final profile = UserProfileModel()
        ..userId = userId
        ..height = height
        ..weight = weight
        ..age = age
        ..gender = gender
        ..goal = goal
        ..trainingLevel = trainingLevel
        ..isLocalAccount = true
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      await db.writeTxn(() async {
        await db.userProfileModels.put(profile);
      });
      return profile;
    }
  }

  Future<UserProfileModel?> getProfile(int userId) async {
    final db = await _db;
    return await db.userProfileModels.filter().userIdEqualTo(userId).findFirst();
  }

  Future<void> deleteProfile(int userId) async {
    final db = await _db;
    await db.writeTxn(() async {
      await db.userProfileModels.filter().userIdEqualTo(userId).deleteAll();
    });
  }
}
