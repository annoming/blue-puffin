import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/coros_activity_source.dart';
import '../../data/http_coros_activity_source.dart';
import '../../data/coros_api_client.dart';
import '../../data/coros_auth_store.dart';
import '../../data/coros_config.dart';
import '../../data/coros_oauth_service.dart';
import '../../data/coros_sync_repository.dart';
import '../../data/mock_coros_activity_source.dart';
import '../../../run/data/models/run_record_model.dart';
import '../models/coros_credentials.dart';
import '../models/coros_sync_batch.dart';

typedef CorosUrlLauncher = Future<bool> Function(Uri url);

final corosConfigProvider = Provider<CorosConfig>((ref) => CorosConfig.fromEnvironment);

final corosUrlLauncherProvider = Provider<CorosUrlLauncher>((ref) {
  return (url) => launchUrl(url, mode: LaunchMode.externalApplication);
});

final corosSyncRepositoryProvider = Provider<CorosSyncRepository>((ref) {
  final config = ref.watch(corosConfigProvider);
  final authStore = CorosAuthStore();
  final oauth = CorosOAuthService(config: config);
  final CorosActivitySource source = config.useMockData
      ? MockCorosActivitySource()
      : HttpCorosActivitySource(CorosApiClient(config: config));

  return CorosSyncRepository(
    config: config,
    authStore: authStore,
    oauth: oauth,
    source: source,
  );
});

final corosRunsProvider = StreamProvider<List<RunRecordModel>>((ref) {
  final repository = ref.watch(corosSyncRepositoryProvider);
  return repository.watchRecentRuns();
});

final corosSyncControllerProvider =
    StateNotifierProvider<CorosSyncController, CorosSyncViewState>((ref) {
  return CorosSyncController(
    repository: ref.watch(corosSyncRepositoryProvider),
    launchUrl: ref.watch(corosUrlLauncherProvider),
  );
});

class CorosSyncViewState {
  const CorosSyncViewState({
    this.isInitializing = true,
    this.isBusy = false,
    this.isAwaitingCallback = false,
    this.credentials,
    this.lastSyncAt,
    this.lastResult,
    this.storedRunCount = 0,
    this.lastError,
    this.infoMessage,
    this.lastSkippedCount = 0,
    this.lastStatus = 'idle',
  });

  final bool isInitializing;
  final bool isBusy;
  final bool isAwaitingCallback;
  final CorosCredentials? credentials;
  final DateTime? lastSyncAt;
  final CorosSyncResult? lastResult;
  final int storedRunCount;
  final String? lastError;
  final String? infoMessage;
  final int lastSkippedCount;
  final String lastStatus;

  bool get isConnected => credentials != null;

  bool get isMock => credentials?.isMock ?? false;

  CorosSyncViewState copyWith({
    bool? isInitializing,
    bool? isBusy,
    bool? isAwaitingCallback,
    CorosCredentials? credentials,
    bool clearCredentials = false,
    DateTime? lastSyncAt,
    CorosSyncResult? lastResult,
    int? storedRunCount,
    String? lastError,
    bool clearError = false,
    String? infoMessage,
    bool clearInfoMessage = false,
    int? lastSkippedCount,
    String? lastStatus,
  }) {
    return CorosSyncViewState(
      isInitializing: isInitializing ?? this.isInitializing,
      isBusy: isBusy ?? this.isBusy,
      isAwaitingCallback: isAwaitingCallback ?? this.isAwaitingCallback,
      credentials: clearCredentials ? null : (credentials ?? this.credentials),
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      lastResult: lastResult ?? this.lastResult,
      storedRunCount: storedRunCount ?? this.storedRunCount,
      lastError: clearError ? null : (lastError ?? this.lastError),
      infoMessage: clearInfoMessage ? null : (infoMessage ?? this.infoMessage),
      lastSkippedCount: lastSkippedCount ?? this.lastSkippedCount,
      lastStatus: lastStatus ?? this.lastStatus,
    );
  }
}

class CorosSyncController extends StateNotifier<CorosSyncViewState> {
  CorosSyncController({
    required this.repository,
    required this.launchUrl,
  }) : super(const CorosSyncViewState()) {
    refresh();
  }

  final CorosSyncRepository repository;
  final CorosUrlLauncher launchUrl;

  Future<void> refresh() async {
    try {
      final snapshot = await repository.loadSnapshot();
      if (!mounted) return;
      state = state.copyWith(
        isInitializing: false,
        credentials: snapshot.credentials,
        clearCredentials: snapshot.credentials == null,
        lastSyncAt: snapshot.lastSyncAt,
        lastStatus: snapshot.lastStatus,
        storedRunCount: snapshot.storedRunCount,
        lastSkippedCount: snapshot.lastSkippedCount,
        lastError: snapshot.lastError,
        clearError: snapshot.lastError == null,
      );
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(isInitializing: false);
    }
  }

  Future<void> connect() async {
    if (state.isBusy) return;
    state = state.copyWith(isBusy: true, clearError: true, clearInfoMessage: true);

    try {
      if (repository.isMockMode) {
        await repository.connectMock();
        await refresh();
        if (!mounted) return;
        state = state.copyWith(
          isBusy: false,
          infoMessage: '演示模式授权成功（未配置 Coros 应用凭据，使用内置样例数据）',
        );
        return;
      }

      final authorizationUrl = await repository.beginAuthorization();
      final opened = await launchUrl(authorizationUrl);
      if (!mounted) return;
      state = state.copyWith(
        isBusy: false,
        isAwaitingCallback: true,
        infoMessage: opened
            ? '已在浏览器打开 Coros 授权页，完成授权后请粘贴回调地址'
            : '无法自动打开浏览器，请手动访问授权页后粘贴回调地址',
      );
    } on CorosAuthException catch (error) {
      if (!mounted) return;
      state = state.copyWith(isBusy: false, lastError: error.message);
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(isBusy: false, lastError: '发起授权失败，请重试');
    }
  }

  /// 深链回调入口：把 `bluepuffin://oauth/coros?code=...&state=...` 传进来。
  Future<bool> completeAuthorization(String callbackUrl) async {
    final uri = Uri.tryParse(callbackUrl.trim());
    if (uri == null) {
      state = state.copyWith(lastError: '回调地址格式不正确');
      return false;
    }

    state = state.copyWith(isBusy: true, clearError: true);
    try {
      await repository.completeAuthorization(uri);
      await refresh();
      if (!mounted) return true;
      state = state.copyWith(
        isBusy: false,
        isAwaitingCallback: false,
        infoMessage: 'Coros 授权成功，可以开始同步历史跑步记录',
      );
      return true;
    } on CorosAuthException catch (error) {
      if (!mounted) return false;
      state = state.copyWith(isBusy: false, lastError: error.message);
      return false;
    } catch (_) {
      if (!mounted) return false;
      state = state.copyWith(isBusy: false, lastError: '授权失败，请重新尝试');
      return false;
    }
  }

  Future<void> sync() async {
    if (state.isBusy) return;
    state = state.copyWith(isBusy: true, clearError: true, clearInfoMessage: true);

    try {
      final result = await repository.sync();
      final snapshot = await repository.loadSnapshot();
      if (!mounted) return;
      state = state.copyWith(
        isBusy: false,
        credentials: snapshot.credentials,
        clearCredentials: snapshot.credentials == null,
        lastResult: result,
        lastSyncAt: snapshot.lastSyncAt,
        storedRunCount: snapshot.storedRunCount,
        lastSkippedCount: result.skipped,
        lastStatus: 'success',
        infoMessage: result.totalSynced > 0
            ? '同步完成：${result.summary}'
            : '同步完成，没有新的跑步记录',
      );
    } on CorosSyncInProgressException {
      if (!mounted) return;
      state = state.copyWith(isBusy: false);
    } on CorosNotConnectedException catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        isBusy: false,
        clearCredentials: true,
        lastError: error.message,
      );
    } on CorosApiException catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        isBusy: false,
        lastError: error.message,
        lastStatus: 'failed',
        clearCredentials: error is CorosUnauthorizedException,
      );
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(
        isBusy: false,
        lastError: '同步失败，请稍后重试',
        lastStatus: 'failed',
      );
    }
  }

  Future<void> disconnect() async {
    await repository.disconnect();
    await refresh();
    if (!mounted) return;
    state = state.copyWith(
      isAwaitingCallback: false,
      clearCredentials: true,
      clearInfoMessage: true,
      infoMessage: '已断开 Coros，已同步的历史记录会保留',
    );
  }

  void clearMessages() {
    state = state.copyWith(clearError: true, clearInfoMessage: true);
  }

  void cancelAuthorization() {
    state = state.copyWith(isAwaitingCallback: false, clearInfoMessage: true);
  }
}
