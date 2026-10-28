import 'package:isar/isar.dart';

import '../../../core/storage/isar_service.dart';
import '../../run/data/models/run_record_model.dart';
import '../domain/models/coros_activity.dart';
import '../domain/models/coros_credentials.dart';
import '../domain/models/coros_sync_batch.dart';
import 'coros_activity_source.dart';
import 'coros_api_client.dart';
import 'coros_auth_store.dart';
import 'coros_config.dart';
import 'coros_oauth_service.dart';
import 'models/coros_sync_state_model.dart';

class CorosNotConnectedException implements Exception {
  CorosNotConnectedException([this.message = '尚未授权 Coros，请先连接账号']);

  final String message;

  @override
  String toString() => message;
}

class CorosSyncInProgressException implements Exception {
  CorosSyncInProgressException() : message = '正在同步中，请稍候';

  final String message;

  @override
  String toString() => message;
}

class CorosSyncSnapshot {
  const CorosSyncSnapshot({
    required this.credentials,
    required this.lastSyncAt,
    required this.lastStatus,
    required this.lastImportedCount,
    required this.lastUpdatedCount,
    required this.lastSkippedCount,
    required this.storedRunCount,
    this.lastError,
  });

  final CorosCredentials? credentials;
  final DateTime? lastSyncAt;
  final String lastStatus;
  final int lastImportedCount;
  final int lastUpdatedCount;
  final int lastSkippedCount;
  final int storedRunCount;
  final String? lastError;

  bool get isConnected => credentials != null;

  bool get hasSynced => lastSyncAt != null;
}

/// Coros 授权 + 历史跑步同步。
///
/// 生产链路：OAuth（PKCE）→ 令牌安全存储 → 分页拉取活动 → 字段映射 →
/// 跑步记录去重入库 → 同步状态落库；未配置应用凭据时由 Mock 数据源替代。
class CorosSyncRepository {
  CorosSyncRepository({
    required this.config,
    required this.authStore,
    required this.oauth,
    required this.source,
    DateTime Function()? clock,
    Future<Isar> Function()? openDb,
  })  : _clock = clock ?? DateTime.now,
        _openDb = openDb ?? IsarService.getInstance;

  final CorosConfig config;
  final CorosAuthStore authStore;
  final CorosOAuthService oauth;
  final CorosActivitySource source;
  final DateTime Function() _clock;
  final Future<Isar> Function() _openDb;

  static const int pageSize = 100;
  static const int maxPages = 20;
  static const Duration initialLookback = Duration(days: 90);
  static const Duration incrementalOverlap = Duration(days: 1);
  static const int maxSkipDetails = 20;

  bool _syncing = false;

  bool get isSyncing => _syncing;

  bool get isMockMode => config.useMockData;

  Future<CorosCredentials?> loadCredentials() => authStore.read();

  /// 发起 OAuth：保存 state / PKCE verifier，返回需要打开的授权页地址。
  Future<Uri> beginAuthorization() async {
    final request = oauth.createAuthorizationRequest(now: _clock());
    await authStore.savePending(request);
    return oauth.buildAuthorizationUrl(request);
  }

  /// 处理 `redirect_uri` 回调：校验 state、换 token、落安全存储。
  Future<CorosCredentials> completeAuthorization(Uri callback) async {
    final params = callback.queryParameters;
    final error = params['error'];
    if (error != null && error.isNotEmpty) {
      await authStore.clearPending();
      throw CorosAuthException(
        params['error_description'] ?? 'Coros 授权被取消或拒绝',
        code: error,
      );
    }

    final pending = await authStore.readPending();
    if (pending == null) {
      throw CorosAuthException('未找到待完成的授权请求，请重新发起授权');
    }
    if (pending.isExpired(_clock())) {
      await authStore.clearPending();
      throw CorosAuthException('授权已超时，请重新发起授权');
    }

    final state = params['state'];
    if (state != pending.state) {
      await authStore.clearPending();
      throw CorosAuthException('授权校验失败（state 不匹配），请重新授权');
    }

    final code = params['code'];
    if (code == null || code.isEmpty) {
      throw CorosAuthException('Coros 回调缺少授权码，请重新授权');
    }

    final credentials = await oauth.exchangeCode(
      code: code,
      codeVerifier: pending.codeVerifier,
      now: _clock(),
    );
    await authStore.save(credentials);
    await authStore.clearPending();
    return credentials;
  }

  /// 演示模式下的一键授权（无需真实 Coros 应用）。
  Future<CorosCredentials> connectMock() async {
    if (!config.useMockData) {
      throw CorosAuthException('已配置真实 Coros 应用凭据，请走正式授权流程');
    }

    final now = _clock().toUtc();
    final credentials = CorosCredentials(
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
      expiresAt: now.add(const Duration(days: 30)),
      scope: CorosConfig.defaultScope,
      accountName: '演示跑者',
      athleteId: 'mock-athlete-001',
      connectedAt: now,
      isMock: true,
    );
    await authStore.save(credentials);
    return credentials;
  }

  Future<void> disconnect() => authStore.clear();

  /// 讲解同步结果给用户看的数据快照。
  Future<CorosSyncSnapshot> loadSnapshot() async {
    final credentials = await authStore.read();
    final db = await _openDb();
    final state = await db.corosSyncStateModels.get(0);
    final storedCount = await db.runRecordModels.filter().sourceEqualTo('coros').count();

    return CorosSyncSnapshot(
      credentials: credentials,
      lastSyncAt: state?.lastSyncAt?.toLocal(),
      lastStatus: state?.lastStatus ?? 'idle',
      lastImportedCount: state?.lastImportedCount ?? 0,
      lastUpdatedCount: state?.lastUpdatedCount ?? 0,
      lastSkippedCount: state?.lastSkippedCount ?? 0,
      storedRunCount: storedCount,
      lastError: state?.lastError,
    );
  }

  List<RunRecordModel> _sortRuns(Iterable<RunRecordModel> runs, int limit) {
    final sorted = runs.toList()..sort((a, b) => b.startTime.compareTo(a.startTime));
    if (sorted.length > limit) return sorted.sublist(0, limit);
    return sorted;
  }

  Future<List<RunRecordModel>> recentRuns({int limit = 50}) async {
    final db = await _openDb();
    return db.runRecordModels
        .filter()
        .sourceEqualTo('coros')
        .sortByStartTimeDesc()
        .limit(limit)
        .findAll();
  }

  Stream<List<RunRecordModel>> watchRecentRuns({int limit = 50}) async* {
    final db = await _openDb();
    yield* db.runRecordModels
        .filter()
        .sourceEqualTo('coros')
        .sortByStartTimeDesc()
        .limit(limit)
        .watch(fireImmediately: true);
  }

  /// 拉取并入库历史跑步记录。
  ///
  /// [from] 为空时：首次同步回溯 90 天，之后从上一次同步时间前推 1 天开始，
  /// 以覆盖上传延迟的活动（重复记录由唯一索引去重）。
  Future<CorosSyncResult> sync({DateTime? from}) async {
    if (_syncing) throw CorosSyncInProgressException();
    _syncing = true;

    final startedAt = _clock().toUtc();
    try {
      final credentials = await _ensureValidCredentials();

      final db = await _openDb();
      final state = await db.corosSyncStateModels.get(0);
      final windowStart = from?.toUtc() ??
          state?.lastSyncAt?.toUtc().subtract(incrementalOverlap) ??
          startedAt.subtract(initialLookback);

      final result = await _pullAndStore(
        credentials: credentials,
        db: db,
        from: windowStart,
        to: startedAt,
      );

      final syncState = state ?? CorosSyncStateModel();
      syncState
        ..id = 0
        ..lastAttemptAt = startedAt
        ..lastSyncAt = startedAt
        ..lastStatus = 'success'
        ..lastImportedCount = result.imported
        ..lastUpdatedCount = result.updated
        ..lastSkippedCount = result.skipped
        ..lastError = null;

      await db.writeTxn(() async {
        await db.corosSyncStateModels.put(syncState);
      });

      return result;
    } catch (error) {
      await _recordFailure(error, startedAt);
      rethrow;
    } finally {
      _syncing = false;
    }
  }

  Future<CorosSyncResult> _pullAndStore({
    required CorosCredentials credentials,
    required Isar db,
    required DateTime from,
    required DateTime to,
  }) async {
    final rawItems = <Map<String, dynamic>>[];

    for (var page = 0; page < maxPages; page++) {
      final response = await source.fetchActivities(
        accessToken: credentials.accessToken,
        from: from,
        to: to,
        page: page,
        pageSize: pageSize,
      );

      rawItems.addAll(response.items);
      if (response.items.isEmpty || !response.hasMore) break;
    }

    final batch = CorosSyncPlanner.collect(
      rawItems,
      maxSkipDetails: maxSkipDetails,
    );

    final syncedAt = _clock().toUtc();
    var imported = 0;
    var updated = 0;

    await db.writeTxn(() async {
      for (final activity in batch.activities) {
        final existing = await db.runRecordModels
            .filter()
            .sourceEqualTo('coros')
            .externalIdEqualTo(activity.externalId)
            .findFirst();

        if (existing == null) {
          await db.runRecordModels.put(_toModel(activity, syncedAt));
          imported += 1;
        } else {
          _applyActivity(existing, activity, syncedAt);
          await db.runRecordModels.put(existing);
          updated += 1;
        }
      }
    });

    return CorosSyncResult(
      imported: imported,
      updated: updated,
      skipped: batch.skippedCount,
      syncedAt: syncedAt.toLocal(),
      skippedRecords: batch.skippedRecords,
    );
  }

  RunRecordModel _toModel(CorosActivity activity, DateTime syncedAt) {
    final model = RunRecordModel()
      ..source = 'coros'
      ..externalId = activity.externalId
      ..createdAt = syncedAt;
    _applyActivity(model, activity, syncedAt);
    return model;
  }

  void _applyActivity(
    RunRecordModel model,
    CorosActivity activity,
    DateTime syncedAt,
  ) {
    model
      ..startTime = activity.startTime
      ..durationSeconds = activity.durationSeconds
      ..distanceMeters = activity.distanceMeters
      ..title = activity.title
      ..sportType = activity.sportType
      ..avgHeartRate = activity.avgHeartRate
      ..calories = activity.calories
      ..syncedAt = syncedAt;
  }

  Future<CorosCredentials> _ensureValidCredentials() async {
    final credentials = await authStore.read();
    if (credentials == null) throw CorosNotConnectedException();

    if (!credentials.isExpired(_clock())) return credentials;

    if (!credentials.canRefresh) {
      await authStore.clear();
      throw CorosNotConnectedException('Coros 登录已过期，请重新授权');
    }

    try {
      final refreshed = await oauth.refresh(credentials, now: _clock());
      await authStore.save(refreshed);
      return refreshed;
    } on CorosAuthException catch (error) {
      // 只有授权本身失效才清除本地登录态；网络抖动保留令牌，下次可重试。
      const terminalCodes = {'invalid_grant', 'invalid_token', 'missing_refresh_token'};
      if (terminalCodes.contains(error.code)) {
        await authStore.clear();
        throw CorosNotConnectedException('Coros 登录已过期，请重新授权');
      }
      rethrow;
    }
  }

  Future<void> _recordFailure(Object error, DateTime attemptedAt) async {
    try {
      final db = await _openDb();
      final state = await db.corosSyncStateModels.get(0) ?? CorosSyncStateModel();
      state
        ..id = 0
        ..lastAttemptAt = attemptedAt
        ..lastStatus = 'failed'
        ..lastError = _friendlyError(error);

      await db.writeTxn(() async {
        await db.corosSyncStateModels.put(state);
      });
    } catch (_) {
      // 状态落库失败不应覆盖原始同步异常。
    }

    if (error is CorosUnauthorizedException) {
      await authStore.clear();
    }
  }

  String _friendlyError(Object error) {
    if (error is CorosNotConnectedException) return error.message;
    if (error is CorosApiException) return error.message;
    if (error is CorosAuthException) return error.message;
    return '同步失败，请稍后重试';
  }

  /// 供训练计划等模块直接按时间范围读取 Coros 跑步记录。
  Future<List<RunRecordModel>> runsBetween({
    required DateTime from,
    required DateTime to,
  }) async {
    final db = await _openDb();
    final runs = await db.runRecordModels
        .filter()
        .sourceEqualTo('coros')
        .startTimeBetween(from.toUtc(), to.toUtc())
        .findAll();
    return _sortRuns(runs, runs.length);
  }
}
