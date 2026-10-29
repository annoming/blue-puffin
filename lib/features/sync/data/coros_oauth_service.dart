import 'package:dio/dio.dart';

import '../domain/models/coros_auth_request.dart';
import '../domain/models/coros_credentials.dart';
import 'coros_config.dart';
import 'coros_pkce.dart';

class CorosAuthException implements Exception {
  CorosAuthException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'CorosAuthException($code): $message';
}

/// Coros OAuth 2.0 授权码流程（带 PKCE）。
///
/// 授权页与令牌端点来自 Coros Partner API（`open.coros.com`）。
/// 具体 scope 与令牌有效期需以审批后拿到的文档为准，默认按 30 天处理。
class CorosOAuthService {
  CorosOAuthService({required this.config, Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                // 错误响应也要解析出 Coros 的错误码，而不是直接抛 DioException。
                validateStatus: (status) => status != null && status < 500,
              ),
            );

  final CorosConfig config;
  final Dio _dio;

  static const Duration defaultTokenLifetime = Duration(days: 30);

  CorosAuthRequest createAuthorizationRequest({DateTime? now}) {
    return CorosAuthRequest(
      state: CorosPkce.createState(),
      codeVerifier: CorosPkce.createCodeVerifier(),
      createdAt: (now ?? DateTime.now()).toUtc(),
    );
  }

  Uri buildAuthorizationUrl(CorosAuthRequest request) {
    return Uri.parse(config.authorizeUrl).replace(
      queryParameters: {
        'response_type': 'code',
        'client_id': config.clientId,
        'redirect_uri': config.redirectUri,
        'scope': config.scope,
        'state': request.state,
        'code_challenge': CorosPkce.codeChallengeS256(request.codeVerifier),
        'code_challenge_method': 'S256',
      },
    );
  }

  Future<CorosCredentials> exchangeCode({
    required String code,
    required String codeVerifier,
    DateTime? now,
  }) async {
    final body = <String, String>{
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': config.redirectUri,
      'client_id': config.clientId,
      'code_verifier': codeVerifier,
    };
    if (config.clientSecret.isNotEmpty) {
      body['client_secret'] = config.clientSecret;
    }

    final json = await _postToken(body);
    return _credentialsFromTokenResponse(json, now: now);
  }

  Future<CorosCredentials> refresh(
    CorosCredentials credentials, {
    DateTime? now,
  }) async {
    final refreshToken = credentials.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw CorosAuthException('登录已过期，请重新授权 Coros', code: 'missing_refresh_token');
    }

    final body = <String, String>{
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': config.clientId,
    };
    if (config.clientSecret.isNotEmpty) {
      body['client_secret'] = config.clientSecret;
    }

    final json = await _postToken(body);
    final refreshed = _credentialsFromTokenResponse(json, now: now);
    return refreshed.copyWith(
      refreshToken: refreshed.refreshToken ?? refreshToken,
      accountName: refreshed.accountName ?? credentials.accountName,
      athleteId: refreshed.athleteId ?? credentials.athleteId,
    );
  }

  Future<Map<String, dynamic>> _postToken(Map<String, String> body) async {
    Response<dynamic> response;
    try {
      response = await _dio.post<dynamic>(
        config.tokenUrl,
        data: body,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioException catch (error) {
      throw CorosAuthException(
        '无法连接 Coros 授权服务，请检查网络后重试',
        code: error.type.name,
      );
    }

    final payload = _asMap(response.data);
    final tokenPayload = _unwrapTokenPayload(payload);

    if (response.statusCode != 200 || tokenPayload['access_token'] == null) {
      final code = _stringOf(tokenPayload, const ['error', 'code', 'errorCode']);
      final message = _stringOf(
        tokenPayload,
        const ['error_description', 'errorDescription', 'message', 'msg'],
      );
      throw CorosAuthException(
        message ?? 'Coros 授权失败（HTTP ${response.statusCode}）',
        code: code,
      );
    }

    return tokenPayload;
  }

  Map<String, dynamic> _unwrapTokenPayload(Map<String, dynamic> payload) {
    for (final key in const ['data', 'result']) {
      final nested = payload[key];
      if (nested is Map) return Map<String, dynamic>.from(nested);
    }
    return payload;
  }

  CorosCredentials _credentialsFromTokenResponse(
    Map<String, dynamic> json, {
    DateTime? now,
  }) {
    final accessToken = _stringOf(json, const ['access_token', 'accessToken', 'token']);
    if (accessToken == null) {
      throw CorosAuthException('Coros 未返回 access_token', code: 'invalid_token_response');
    }

    final expiresIn = _intOf(json, const ['expires_in', 'expiresIn']);
    final issuedAt = (now ?? DateTime.now()).toUtc();
    final expiresAt = expiresIn != null && expiresIn > 0
        ? issuedAt.add(Duration(seconds: expiresIn))
        : issuedAt.add(defaultTokenLifetime);

    return CorosCredentials(
      accessToken: accessToken,
      refreshToken: _stringOf(json, const ['refresh_token', 'refreshToken']),
      expiresAt: expiresAt,
      scope: _stringOf(json, const ['scope']),
      accountName: _stringOf(json, const [
        'userName',
        'user_name',
        'account',
        'displayName',
        'nickname',
      ]),
      athleteId: _stringOf(json, const ['uid', 'userId', 'user_id', 'openId', 'open_id']),
      connectedAt: issuedAt,
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    return const {};
  }

  static String? _stringOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
      if (value is num) return value.toString();
    }
    return null;
  }

  static int? _intOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is int) return value;
      if (value is num) return value.round();
      if (value is String) {
        final parsed = int.tryParse(value.trim());
        if (parsed != null) return parsed;
      }
    }
    return null;
  }
}
