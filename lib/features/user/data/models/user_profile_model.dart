import 'package:isar/isar.dart';

part 'user_profile_model.g.dart';

@collection
class UserProfileModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int userId;

  // 本地用户建档信息
  double? height; // cm
  double? weight; // kg
  int? age;
  String? gender; // 男/女/其他

  String? goal; // 5K/10K/半马/全马/其他
  String? trainingLevel; // 初学/入门/进阶/高级

  bool isLocalAccount = true; // 本地账号标记（无后端）

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
