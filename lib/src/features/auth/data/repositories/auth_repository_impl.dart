import 'package:auth_graphql/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.data.gql.dart';
import 'package:ferry/ferry.dart';

import '../params/__generated__/token.var.gql.dart';

abstract class AuthRepository {
  Stream<OperationResponse<GAnonymousTokenData, GAnonymousTokenVars>> getAnonymousToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<OperationResponse<GAnonymousTokenData, GAnonymousTokenVars>> getAnonymousToken() {
    return remoteDataSource.getAnonymousToken();
  }
}

