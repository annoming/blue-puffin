import 'coros_activity_source.dart';
import 'models/coros_activity_page.dart';

/// 演示 / 测试用 Coros 数据源。
///
/// 返回的数据刻意混合了跑步、骑行、零里程和字段缺失的记录，
/// 用于验证「只同步跑步、非法记录跳过、重复同步不重复入库」。
class MockCorosActivitySource implements CorosActivitySource {
  MockCorosActivitySource({DateTime? now, this.latency = Duration.zero})
      : _now = (now ?? DateTime.now()).toUtc();

  final DateTime _now;

  /// UI 演示时可设置少量延迟以展示 loading 状态。
  final Duration latency;

  @override
  Future<CorosActivityPage> fetchActivities({
    required String accessToken,
    required DateTime from,
    required DateTime to,
    required int page,
    required int pageSize,
  }) async {
    if (latency > Duration.zero) {
      await Future<void>.delayed(latency);
    }

    final fromUtc = from.toUtc();
    final toUtc = to.toUtc();
    final filtered = _fixtures()
        .where((item) {
          final startedAt = _startTimeOf(item['startTime']);
          if (startedAt == null) return false;
          return !startedAt.isBefore(fromUtc) && !startedAt.isAfter(toUtc);
        })
        .toList(growable: false);

    final startIndex = page * pageSize;
    if (startIndex >= filtered.length) {
      return CorosActivityPage(
        items: const [],
        page: page,
        pageSize: pageSize,
        total: filtered.length,
      );
    }

    final endIndex =
        startIndex + pageSize < filtered.length ? startIndex + pageSize : filtered.length;

    return CorosActivityPage(
      items: filtered.sublist(startIndex, endIndex),
      page: page,
      pageSize: pageSize,
      total: filtered.length,
    );
  }

  DateTime? _startTimeOf(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true);
    }
    if (value is String) {
      return DateTime.tryParse(value)?.toUtc();
    }
    return null;
  }

  List<Map<String, dynamic>> _fixtures() {
    int at(Duration ago, {int hour = 7, int minute = 10}) {
      final day = DateTime.utc(_now.year, _now.month, _now.day).subtract(ago);
      return DateTime.utc(day.year, day.month, day.day, hour, minute)
          .millisecondsSinceEpoch ~/
          1000;
    }

    return [
      // 正常路跑：字段形态 A（startTime 秒级时间戳 + distance 米）。
      {
        'id': 'mock-coros-run-1001',
        'name': '晨跑 10K',
        'sportType': 100,
        'startTime': at(const Duration(days: 1)),
        'duration': 3120, // 52:00
        'distance': 10250,
        'avgHeartRate': 152,
        'calories': 640,
      },
      // 越野跑：字段形态 B（totalTime / totalDistance）。
      {
        'id': 'mock-coros-run-1002',
        'name': '周末越野',
        'sportType': 102,
        'startTime': at(const Duration(days: 3), hour: 8, minute: 0),
        'totalTime': 8100, // 2:15:00
        'totalDistance': 21400,
        'avgHr': 146,
        'calories': 1350,
      },
      // 场地跑：ISO 时间字符串 + 公里字段。
      {
        'id': 'mock-coros-run-1003',
        'name': '操场节奏跑',
        'sportType': 103,
        'startTime':
            DateTime.utc(_now.year, _now.month, _now.day)
                .subtract(const Duration(days: 5, hours: 12))
                .toIso8601String(),
        'durationSeconds': 2700,
        'distanceKm': 8.0,
      },
      // 非跑步，应被跳过。
      {
        'id': 'mock-coros-bike-2001',
        'name': '周末骑行',
        'sportType': 200,
        'startTime': at(const Duration(days: 2), hour: 9),
        'duration': 5400,
        'distance': 40000,
      },
      // 跑步机记录但里程为 0，应被跳过。
      {
        'id': 'mock-coros-run-1004',
        'name': '室内跑步',
        'sportType': 101,
        'startTime': at(const Duration(days: 4), hour: 20),
        'duration': 1800,
        'distance': 0,
      },
      // 缺少活动 ID，应被跳过。
      {
        'name': '异常记录',
        'sportType': 100,
        'startTime': at(const Duration(days: 6), hour: 6),
        'duration': 1200,
        'distance': 3000,
      },
    ];
  }
}
