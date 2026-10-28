import 'package:isar/isar.dart';

part 'coros_sync_state_model.g.dart';

/// Coros 同步状态（单例记录，固定 id = 0）。
@collection
class CorosSyncStateModel {
  Id id = 0;

  DateTime? lastAttemptAt;

  DateTime? lastSyncAt;

  /// `success` / `failed`
  String lastStatus = 'idle';

  int lastImportedCount = 0;

  int lastUpdatedCount = 0;

  int lastSkippedCount = 0;

  String? lastError;
}
