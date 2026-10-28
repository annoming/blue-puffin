/// Coros OAuth 授权凭据。
///
/// 只依赖 Dart 核心库，便于单元测试；持久化由 `CorosAuthStore` 负责，
/// 令牌统一存放在系统 Keychain / Keystore 中，不落 Isar 明文库。
class CorosCredentials {
  const CorosCredentials({
    required this.accessToken,
    required this.connectedAt,
    this.refreshToken,
    this.expiresAt,
    this.scope,
    this.accountName,
    this.athleteId,
    this.isMock = false,
  });

  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final String? scope;
  final String? accountName;
  final String? athleteId;
  final DateTime connectedAt;

  /// 演示模式（未配置 Coros 应用凭据）下生成的本地凭据。
  final bool isMock;

  /// 提前 60 秒视为过期，避免请求发出时恰好失效。
  bool isExpired(DateTime now, {Duration skew = const Duration(seconds: 60)}) {
    final expiry = expiresAt;
    if (expiry == null) return false;
    return !now.add(skew).isBefore(expiry);
  }

  bool get canRefresh => (refreshToken ?? '').isNotEmpty;

  CorosCredentials copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? scope,
    String? accountName,
    String? athleteId,
    DateTime? connectedAt,
    bool? isMock,
  }) {
    return CorosCredentials(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      scope: scope ?? this.scope,
      accountName: accountName ?? this.accountName,
      athleteId: athleteId ?? this.athleteId,
      connectedAt: connectedAt ?? this.connectedAt,
      isMock: isMock ?? this.isMock,
    );
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        if (refreshToken != null) 'refreshToken': refreshToken,
        if (expiresAt != null) 'expiresAt': expiresAt!.toUtc().toIso8601String(),
        if (scope != null) 'scope': scope,
        if (accountName != null) 'accountName': accountName,
        if (athleteId != null) 'athleteId': athleteId,
        'connectedAt': connectedAt.toUtc().toIso8601String(),
        'isMock': isMock,
      };

  static CorosCredentials? fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'];
    final connectedAt = json['connectedAt'];
    if (accessToken is! String || accessToken.isEmpty || connectedAt is! String) {
      return null;
    }

    final parsedConnectedAt = DateTime.tryParse(connectedAt);
    if (parsedConnectedAt == null) return null;

    return CorosCredentials(
      accessToken: accessToken,
      refreshToken: json['refreshToken'] as String?,
      expiresAt: DateTime.tryParse((json['expiresAt'] as String?) ?? '')?.toUtc(),
      scope: json['scope'] as String?,
      accountName: json['accountName'] as String?,
      athleteId: json['athleteId'] as String?,
      connectedAt: parsedConnectedAt.toUtc(),
      isMock: json['isMock'] == true,
    );
  }
}
