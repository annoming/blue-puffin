import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? email;

  @Index(unique: true, replace: true)
  String? phone;

  String? passwordHash;

  bool isProfileCompleted = false;

  DateTime createdAt = DateTime.now();

  DateTime updatedAt = DateTime.now();
}
