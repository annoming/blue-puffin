import 'dart:convert';

/// 一次待完成的 OAuth 授权请求（state + PKCE code verifier）。
class CorosAuthRequest {
  const CorosAuthRequest({
    required this.state,
    required this.codeVerifier,
    required this.createdAt,
  });

  final String state;
  final String codeVerifier;
  final DateTime createdAt;

  bool isExpired(DateTime now, {Duration ttl = const Duration(minutes: 10)}) {
    return now.difference(createdAt) > ttl;
  }

  Map<String, dynamic> toJson() => {
        'state': state,
        'codeVerifier': codeVerifier,
        'createdAt': createdAt.toUtc().toIso8601String(),
      };

  static CorosAuthRequest? fromJson(Map<String, dynamic> json) {
    final state = json['state'];
    final verifier = json['codeVerifier'];
    final createdAt = DateTime.tryParse((json['createdAt'] as String?) ?? '');
    if (state is! String || verifier is! String || createdAt == null) return null;
    return CorosAuthRequest(
      state: state,
      codeVerifier: verifier,
      createdAt: createdAt.toUtc(),
    );
  }

  String encode() => jsonEncode(toJson());

  static CorosAuthRequest? decode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      return null;
    }
  }
}
