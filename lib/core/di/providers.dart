import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/user/data/user_profile_repository.dart';
import '../../features/profile/data/profile_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final userProfileRepositoryProvider = Provider((ref) => UserProfileRepository());
final profileRepositoryProvider = Provider((ref) => ProfileRepository());
