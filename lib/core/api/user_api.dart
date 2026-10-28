import '../storage/isar_service.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/profile/data/models/profile_model.dart';
import '../../features/profile/data/profile_repository.dart';

class UserApi {
  final _profileRepository = ProfileRepository();

  Future<Map<String, dynamic>> getUserInfo(int userId) async {
    final db = await IsarService.getInstance();
    final user = await db.userModels.get(userId);
    final profile = await _profileRepository.getProfile(userId);

    if (user == null) {
      throw Exception('User not found');
    }

    return {
      'user': {
        'id': user.id,
        'email': user.email,
        'phone': user.phone,
        'isProfileCompleted': user.isProfileCompleted,
        'createdAt': user.createdAt.toIso8601String(),
      },
      'profile': profile != null
          ? {
              'id': profile.id,
              'userId': profile.userId,
              'currentWeeklyMileage': profile.currentWeeklyMileage,
              'targetRaceTime': profile.targetRaceTime,
              'targetRaceType': profile.targetRaceType,
              'availableTrainingDays': profile.availableTrainingDays,
              'injuryHistory': profile.injuryHistory,
              'dietaryPreferences': profile.dietaryPreferences,
              'allergies': profile.allergies,
              'trainingGoal': profile.trainingGoal,
              'createdAt': profile.createdAt.toIso8601String(),
              'updatedAt': profile.updatedAt.toIso8601String(),
            }
          : null,
    };
  }
}
