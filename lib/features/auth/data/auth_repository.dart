import 'package:isar/isar.dart';
import '../data/models/user_model.dart';
import '../../../core/storage/isar_service.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthRepository {
  Future<Isar> get _db async => await IsarService.getInstance();

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserModel?> registerWithEmail(String email, String password) async {
    final db = await _db;
    final existing = await db.userModels.filter().emailEqualTo(email).findFirst();
    if (existing != null) {
      throw Exception('User with this email already exists');
    }

    final user = UserModel()
      ..email = email
      ..passwordHash = _hashPassword(password)
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await db.writeTxn(() async {
      await db.userModels.put(user);
    });
    return user;
  }

  Future<UserModel?> registerWithPhone(String phone, String password) async {
    final db = await _db;
    final existing = await db.userModels.filter().phoneEqualTo(phone).findFirst();
    if (existing != null) {
      throw Exception('User with this phone already exists');
    }

    final user = UserModel()
      ..phone = phone
      ..passwordHash = _hashPassword(password)
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await db.writeTxn(() async {
      await db.userModels.put(user);
    });
    return user;
  }

  Future<UserModel?> login(String identifier, String password) async {
    final db = await _db;
    UserModel? user;
    if (identifier.contains('@')) {
      user = await db.userModels.filter().emailEqualTo(identifier).findFirst();
    } else {
      user = await db.userModels.filter().phoneEqualTo(identifier).findFirst();
    }

    if (user == null) {
      throw Exception('User not found');
    }

    if (user.passwordHash != _hashPassword(password)) {
      throw Exception('Invalid password');
    }

    return user;
  }

  Future<UserModel?> getUserById(int id) async {
    final db = await _db;
    return await db.userModels.get(id);
  }

  Future<void> logout() async {
    // 本地模式：登出操作（可清理登录态）
    return;
  }
}
