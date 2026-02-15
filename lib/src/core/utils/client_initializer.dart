import 'package:auth_graphql/src/core/constants/constants.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

Client initClient(String path) {
  final link = HttpLink("${AppConstants.baseUrl}$path");

  final cache = Cache();

  final client = Client(
    link: link,
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheAndNetwork,
    },
  );

  return client;
}
