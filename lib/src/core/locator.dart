import 'package:auth_graphql/src/core/constants/constants.dart';
import 'package:auth_graphql/src/core/utils/client_initializer.dart';
import 'package:auth_graphql/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:auth_graphql/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ferry/ferry.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initDI() {
  // Register Ferry clients
  locator.registerLazySingleton<Client>(
    () => initClient(AppConstants.authService),
    instanceName: AppConstants.authService,
  );
  locator.registerLazySingleton<Client>(
    () => initClient(AppConstants.profileService),
    instanceName: AppConstants.profileService,
  );

  // Register data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      locator<Client>(instanceName: AppConstants.authService),
    ),
  );

  // Register repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<AuthRemoteDataSource>()),
  );
}
