import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.data.gql.dart';
import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.req.gql.dart';
import 'package:ferry/ferry.dart';

import '../params/__generated__/token.var.gql.dart';

abstract class AuthRemoteDataSource {
  Stream<OperationResponse<GAnonymousTokenData, GAnonymousTokenVars>> getAnonymousToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Stream<OperationResponse<GAnonymousTokenData, GAnonymousTokenVars>> getAnonymousToken() {
    final request = GAnonymousTokenReq();
    return client.request(request);
  }
}

