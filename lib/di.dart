

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/data/datasource/remote/event/events_api_service.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';
import 'data/datasource/remote/chat/chats_api_service.dart';
import 'views/bloc_container.dart';
import 'data/repositories_impl_container.dart';
import 'domain/repositories_container.dart';

var di = GetIt.instance;

initDependencies() async {

  // REST CLIENT
  final dio = Dio();
  dio.options.baseUrl = AppConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 10);
  di.registerSingleton<Dio>(dio);

  // BLOCS
  di.registerFactory<SplashBloc>(() => SplashBloc(
      dio: di(),
      messagingService: di(),
    usersRepository: di()
  ));
  di.registerFactory<LoginBloc>(() => LoginBloc(di(), di()));
  di.registerFactory<RegisterBloc>(() => RegisterBloc(di(), di()));
  di.registerFactory<ProfileBloc>(() => ProfileBloc(di()));
  di.registerFactory<CreateEventBloc>(() => CreateEventBloc(di()));
  di.registerFactory<PickPersonBloc>(() => PickPersonBloc(di()));

  // REPOSITORIES
  di.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(di(), di()));
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      apiService: di(),
      localService: di(),
      dio: di()
  ));
  di.registerLazySingleton<EventsRepository>(() => EventsRepositoryImpl(
    authRepository: di(),
    eventsApiService: di()
  ));

  // DATASOURCES
  // REMOTE
  di.registerLazySingleton<UsersApiService>(() => UsersApiService(di()));
  di.registerLazySingleton<AuthApiService>(() => AuthApiService(di()));
  di.registerLazySingleton<EventsApiService>(() => EventsApiService(di()));
  di.registerLazySingleton<ChatsApiService>(() => ChatsApiService(di()));

  // LOCAL
  di.registerLazySingleton<AuthLocalService>(() => AuthLocalService());

  // UTILS
  di.registerLazySingleton<MessagingService>(() => MessagingService(di()));
}