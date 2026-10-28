import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// OAuth 2.0 PKCE（RFC 7636）辅助方法。
///
/// 移动端无法安全保存 client secret，因此以 PKCE + state 防止授权码被截获重放。
class CorosPkce {
  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String createCodeVerifier([Random? random]) {
    final rnd = random ?? Random.secure();
    return List.generate(64, (_) => _charset[rnd.nextInt(_charset.length)]).join();
  }

  static String codeChallengeS256(String verifier) {
    final digest = sha256.convert(utf8.encode(verifier));
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  static String createState([Random? random]) {
    final rnd = random ?? Random.secure();
    final bytes = List<int>.generate(24, (_) => rnd.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}
