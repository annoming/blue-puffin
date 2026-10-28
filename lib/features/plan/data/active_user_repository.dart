import 'package:isar/isar.dart';

import '../../../core/storage/isar_service.dart';
import '../../auth/data/models/user_model.dart';
import '../../profile/data/models/profile_model.dart';

/// 本地账号模式下解析当前用户。
///
/// MVP 为单机单账号：优先取最近登录/创建的用户；若只有建档数据，
/// 则回退到建档记录上的 userId。读取失败时返回 null，由计划生成走兜底。
class ActiveUserRepository {
  Future<int?> currentUserId() async {
    try {
      final Isar db = await IsarService.getInstance();
      final List<UserModel> users = await db.userModels.where().findAll();
      if (users.isNotEmpty) {
        users.sort(
          (UserModel a, UserModel b) => b.createdAt.compareTo(a.createdAt),
        );
        return users.first.id;
      }

      final ProfileModel? profile = await db.profileModels.where().findFirst();
      return profile?.userId;
    } catch (_) {
      return null;
    }
  }
}
