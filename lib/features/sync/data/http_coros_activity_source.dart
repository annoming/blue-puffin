import 'coros_activity_source.dart';
import 'coros_api_client.dart';
import 'models/coros_activity_page.dart';

class HttpCorosActivitySource implements CorosActivitySource {
  HttpCorosActivitySource(this._client);

  final CorosApiClient _client;

  @override
  Future<CorosActivityPage> fetchActivities({
    required String accessToken,
    required DateTime from,
    required DateTime to,
    required int page,
    required int pageSize,
  }) {
    return _client.fetchActivities(
      accessToken: accessToken,
      from: from,
      to: to,
      page: page,
      pageSize: pageSize,
    );
  }
}
