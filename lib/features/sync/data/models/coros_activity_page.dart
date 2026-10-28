/// Coros 活动列表分页响应。
///
/// Coros Partner API 的响应包装格式未公开，不同环境出现过
/// `{data: {dataList: []}}`、`{data: {list: []}}`、`{result: {activities: []}}`
/// 以及直接返回数组等形态，这里做统一归一化。
class CorosActivityPage {
  const CorosActivityPage({
    required this.items,
    required this.page,
    required this.pageSize,
    this.total,
  });

  final List<Map<String, dynamic>> items;
  final int page;
  final int pageSize;
  final int? total;

  bool get hasMore {
    final totalCount = total;
    if (totalCount != null) {
      return (page + 1) * pageSize < totalCount;
    }
    return items.length >= pageSize;
  }

  static CorosActivityPage fromBody(
    dynamic body, {
    required int page,
    required int pageSize,
  }) {
    final items = _extractList(body)
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList(growable: false);

    return CorosActivityPage(
      items: items,
      page: page,
      pageSize: pageSize,
      total: _extractTotal(body),
    );
  }

  static List<dynamic> _extractList(dynamic body) {
    if (body is List) return body;
    if (body is! Map) return const [];

    for (final key in const ['data', 'result', 'payload']) {
      final value = body[key];
      if (value is List) return value;
      if (value is Map) {
        for (final listKey in const [
          'dataList',
          'data_list',
          'list',
          'activities',
          'activityList',
          'items',
          'records',
        ]) {
          final list = value[listKey];
          if (list is List) return list;
        }
      }
    }

    for (final listKey in const ['dataList', 'list', 'activities', 'items', 'records']) {
      final list = body[listKey];
      if (list is List) return list;
    }

    return const [];
  }

  static int? _extractTotal(dynamic body) {
    if (body is! Map) return null;

    for (final container in [body, body['data'], body['result'], body['payload']]) {
      if (container is! Map) continue;
      for (final key in const ['total', 'totalCount', 'total_count', 'count']) {
        final value = container[key];
        if (value is int) return value;
        if (value is num) return value.round();
        if (value is String) {
          final parsed = int.tryParse(value);
          if (parsed != null) return parsed;
        }
      }
    }
    return null;
  }
}
