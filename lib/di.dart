

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'views/bloc_container.dart';
import 'data/repositories_impl_container.dart';
import 'domain/repositories_container.dart';

var di = GetIt.instance;

initDependencies() async {

  // REST CLIENT
  final dio = Dio();
  di.registerSingleton<Dio>(dio);

  // BLOCS
  di.registerFactory<SplashBloc>(() => SplashBloc());
  di.registerFactory<LoginBloc>(() => LoginBloc(di()));
  di.registerFactory<RegisterBloc>(() => RegisterBloc());
  // REPOSITORIES
  di.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(di()));

  // DATASOURCES
  di.registerLazySingleton<UsersApiService>(() => UsersApiService(di()));

}