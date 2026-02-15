// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.data.gql.dart'
    show GAnonymousTokenData, GAnonymousTokenData_anonymousToken;
import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.req.gql.dart'
    show GAnonymousTokenReq;
import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.var.gql.dart'
    show GAnonymousTokenVars;
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAnonymousTokenData,
  GAnonymousTokenData_anonymousToken,
  GAnonymousTokenReq,
  GAnonymousTokenVars,
])
final Serializers serializers = _serializersBuilder.build();
