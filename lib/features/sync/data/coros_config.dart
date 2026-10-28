/// Coros 接入配置。
///
/// 正式环境需要在 Coros Partner API 申请通过后拿到 client id / secret，
/// 并通过 `--dart-define` 注入，避免把密钥写进仓库：
///
/// ```
/// flutter run \
///   --dart-define=COROS_CLIENT_ID=xxx \
///   --dart-define=COROS_CLIENT_SECRET=xxx \
///   --dart-define=COROS_REDIRECT_URI=bluepuffin://oauth/coros
/// ```
///
/// 未注入 client id 时自动进入演示模式（Mock 数据源），
/// 用于本地联调和验收「授权 + 同步至少 1 条记录」。
class CorosConfig {
  const CorosConfig({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
    this.authorizeUrl = defaultAuthorizeUrl,
    this.tokenUrl = defaultTokenUrl,
    this.apiBaseUrl = defaultApiBaseUrl,
    this.activitiesPath = defaultActivitiesPath,
    this.scope = defaultScope,
    this.forceMock = false,
  });

  static const String defaultAuthorizeUrl = 'https://open.coros.com/oauth2/authorize';
  static const String defaultTokenUrl = 'https://open.coros.com/oauth2/token';
  static const String defaultApiBaseUrl = 'https://open.coros.com';
  static const String defaultActivitiesPath = '/v1/activities';
  static const String defaultScope = 'activity:read';

  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final String authorizeUrl;
  final String tokenUrl;
  final String apiBaseUrl;
  final String activitiesPath;
  final String scope;
  final bool forceMock;

  static const CorosConfig fromEnvironment = CorosConfig(
    clientId: String.fromEnvironment('COROS_CLIENT_ID'),
    clientSecret: String.fromEnvironment('COROS_CLIENT_SECRET'),
    redirectUri: String.fromEnvironment(
      'COROS_REDIRECT_URI',
      defaultValue: 'bluepuffin://oauth/coros',
    ),
    authorizeUrl: String.fromEnvironment(
      'COROS_AUTHORIZE_URL',
      defaultValue: defaultAuthorizeUrl,
    ),
    tokenUrl: String.fromEnvironment('COROS_TOKEN_URL', defaultValue: defaultTokenUrl),
    apiBaseUrl: String.fromEnvironment(
      'COROS_API_BASE_URL',
      defaultValue: defaultApiBaseUrl,
    ),
    activitiesPath: String.fromEnvironment(
      'COROS_ACTIVITIES_PATH',
      defaultValue: defaultActivitiesPath,
    ),
    scope: String.fromEnvironment('COROS_SCOPE', defaultValue: defaultScope),
    forceMock: bool.fromEnvironment('COROS_USE_MOCK'),
  );

  bool get isConfigured => clientId.trim().isNotEmpty;

  bool get useMockData => forceMock || !isConfigured;

  CorosConfig copyWith({
    String? clientId,
    String? clientSecret,
    String? redirectUri,
    String? authorizeUrl,
    String? tokenUrl,
    String? apiBaseUrl,
    String? activitiesPath,
    String? scope,
    bool? forceMock,
  }) {
    return CorosConfig(
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      redirectUri: redirectUri ?? this.redirectUri,
      authorizeUrl: authorizeUrl ?? this.authorizeUrl,
      tokenUrl: tokenUrl ?? this.tokenUrl,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      activitiesPath: activitiesPath ?? this.activitiesPath,
      scope: scope ?? this.scope,
      forceMock: forceMock ?? this.forceMock,
    );
  }
}
