import 'models/coros_activity_page.dart';

/// 活动数据源抽象。
///
/// 生产环境走 [HttpCorosActivitySource]；未配置 Coros 应用凭据时使用
/// [MockCorosActivitySource] 走通授权 → 同步 → 展示链路，便于联调与验收。
abstract class CorosActivitySource {
  Future<CorosActivityPage> fetchActivities({
    required String accessToken,
    required DateTime from,
    required DateTime to,
    required int page,
    required int pageSize,
  });
}
