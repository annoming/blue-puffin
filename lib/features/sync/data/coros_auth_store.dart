import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/models/coros_auth_request.dart';
import '../domain/models/coros_credentials.dart';

/// Coros 令牌安全存储。
///
/// access/refresh token 是可直接读取用户训练数据的凭据，
/// 因此写入系统 Keychain（iOS）/ Keystore（Android），不进入 Isar 明文库。
class CorosAuthStore {
  CorosAuthStore({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  static const String _credentialsKey = 'coros.credentials.v1';
  static const String _pendingAuthKey = 'coros.pending_auth.v1';

  final FlutterSecureStorage _storage;

  Future<CorosCredentials?> read() async {
    final raw = await _storage.read(key: _credentialsKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return CorosCredentials.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      // 数据损坏时清除，避免每次启动都失败。
      await clear();
      return null;
    }
  }

  Future<void> save(CorosCredentials credentials) async {
    await _storage.write(
      key: _credentialsKey,
      value: jsonEncode(credentials.toJson()),
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _credentialsKey);
    await clearPending();
  }

  Future<void> savePending(CorosAuthRequest request) async {
    await _storage.write(key: _pendingAuthKey, value: request.encode());
  }

  Future<CorosAuthRequest?> readPending() async {
    final raw = await _storage.read(key: _pendingAuthKey);
    return CorosAuthRequest.decode(raw);
  }

  Future<void> clearPending() async {
    await _storage.delete(key: _pendingAuthKey);
  }
}
