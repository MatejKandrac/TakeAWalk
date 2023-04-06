

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:take_a_walk_app/data/datasource/local/auth_local_service.dart';
import 'package:take_a_walk_app/data/datasource/remote/auth/auth_api_service.dart';
import 'package:take_a_walk_app/data/repository/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'views/bloc_container.dart';
import 'data/repositories_impl_container.dart';
import 'domain/repositories_container.dart';

var di = GetIt.instance;

initDependencies() async {

  // REST CLIENT
  final dio = Dio();
  di.registerSingleton<Dio>(dio);

  // BLOCS
  di.registerFactory<SplashBloc>(() => SplashBloc(di()));
  di.registerFactory<LoginBloc>(() => LoginBloc(di()));
  di.registerFactory<RegisterBloc>(() => RegisterBloc(di()));

  // REPOSITORIES
  di.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(di()));
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      apiService: di(),
      localService: di())
  );

  // DATASOURCES
  // REMOTE
  di.registerLazySingleton<UsersApiService>(() => UsersApiService(di()));
  di.registerLazySingleton<AuthApiService>(() => AuthApiService(di()));

  // LOCAL
  di.registerLazySingleton<AuthLocalService>(() => AuthLocalService());

}