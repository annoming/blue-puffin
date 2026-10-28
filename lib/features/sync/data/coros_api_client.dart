import 'package:dio/dio.dart';

import 'coros_config.dart';
import 'models/coros_activity_page.dart';

class CorosApiException implements Exception {
  CorosApiException(this.message, {this.statusCode, this.code});

  final String message;
  final int? statusCode;
  final String? code;

  @override
  String toString() => 'CorosApiException($statusCode/$code): $message';
}

class CorosUnauthorizedException extends CorosApiException {
  CorosUnauthorizedException(super.message, {super.statusCode, super.code});
}

/// Coros 活动列表 HTTP 客户端。
///
/// 端点路径和查询参数集中在 [CorosConfig]，拿到 Partner API 正式文档后
/// 只需调整配置，无需改动同步逻辑。
class CorosApiClient {
  CorosApiClient({required this.config, Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: config.apiBaseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 30),
                validateStatus: (status) => status != null && status < 500,
              ),
            );

  final CorosConfig config;
  final Dio _dio;

  Future<CorosActivityPage> fetchActivities({
    required String accessToken,
    required DateTime from,
    required DateTime to,
    required int page,
    required int pageSize,
  }) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get<dynamic>(
        config.activitiesPath,
        queryParameters: {
          'startTime': from.toUtc().millisecondsSinceEpoch ~/ 1000,
          'endTime': to.toUtc().millisecondsSinceEpoch ~/ 1000,
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (error) {
      throw CorosApiException(
        '拉取 Coros 活动失败，请检查网络后重试',
        code: error.type.name,
      );
    }

    if (response.statusCode == 401) {
      throw CorosUnauthorizedException(
        'Coros 登录已失效，请重新授权',
        statusCode: 401,
      );
    }

    if (response.statusCode != 200) {
      final payload = response.data is Map
          ? Map<String, dynamic>.from(response.data as Map)
          : const <String, dynamic>{};
      throw CorosApiException(
        _errorMessage(payload) ?? '拉取 Coros 活动失败（HTTP ${response.statusCode}）',
        statusCode: response.statusCode,
        code: _errorCode(payload),
      );
    }

    return CorosActivityPage.fromBody(
      response.data,
      page: page,
      pageSize: pageSize,
    );
  }

  static String? _errorMessage(Map<String, dynamic> payload) {
    for (final key in const ['message', 'msg', 'error_description', 'error']) {
      final value = payload[key];
      if (value is String && value.isNotEmpty) return value;
    }
    final data = payload['data'];
    if (data is Map) {
      return _errorMessage(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static String? _errorCode(Map<String, dynamic> payload) {
    for (final key in const ['code', 'errorCode', 'error']) {
      final value = payload[key];
      if (value is String && value.isNotEmpty) return value;
      if (value is num) return value.toString();
    }
    return null;
  }
}
