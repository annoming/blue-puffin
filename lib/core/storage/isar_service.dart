import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/profile/data/models/profile_model.dart';
import '../../features/user/data/models/user_profile_model.dart';

class IsarService {
  static Isar? _isar;

  static Future<Isar> getInstance() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserModelSchema, ProfileModelSchema, UserProfileModelSchema],
      directory: dir.path,
    );
    return _isar!;
  }

  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
