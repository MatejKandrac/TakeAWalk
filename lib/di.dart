import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/data/datasource/local/profile_local_service.dart';
import 'package:take_a_walk_app/data/datasource/remote/event/events_api_service.dart';
import 'package:take_a_walk_app/data/repository/chats_repository.dart';
import 'package:take_a_walk_app/domain/repositories/chats_repository.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';
import 'package:take_a_walk_app/utils/persistence/app_database.dart';
import 'package:take_a_walk_app/views/profile/edit/bloc/profile_edit_bloc.dart';
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

  // Local database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  di.registerLazySingleton<AppDatabase>(() => database);

  // BLOCS
  di.registerFactory<SplashBloc>(() => SplashBloc(dio: di(), messagingService: di(), usersRepository: di()));
  di.registerFactory<LoginBloc>(() => LoginBloc(di(), di()));
  di.registerFactory<RegisterBloc>(() => RegisterBloc(di(), di()));
  di.registerFactory<ProfileBloc>(() => ProfileBloc(
      dio: di(),
      repository: di()
  ));
  di.registerFactory<ProfileEditBloc>(() => ProfileEditBloc(di()));
  di.registerFactory<CreateEventBloc>(() => CreateEventBloc(di(), di()));
  di.registerFactory<PickPersonBloc>(() => PickPersonBloc(di(), di()));
  di.registerFactory<EventDetailBloc>(() => EventDetailBloc(
    authRepository: di(),
    repository: di(),
    dio: di()
  ));
  di.registerFactory<EventEditBloc>(() => EventEditBloc(di(), di()));
  di.registerFactory<ForecastBloc>(() => ForecastBloc(di()));
  di.registerFactory<MyEventsBloc>(() => MyEventsBloc(di()));
  di.registerFactory<InvitesBloc>(() => InvitesBloc(di()));
  di.registerFactory<MapBloc>(() => MapBloc(di()));
  di.registerFactory<ChatBloc>(() => ChatBloc(di(), di(), di()));

  // REPOSITORIES
  di.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(di(), di(), di()));
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(apiService: di(), localService: di(), dio: di()));
  di.registerLazySingleton<EventsRepository>(() => EventsRepositoryImpl(authRepository: di(), eventsApiService: di()));
  di.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl(authRepository: di(), chatsApiService: di()));
  di.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(di()));

  // DATASOURCES
  // REMOTE
  di.registerLazySingleton<UsersApiService>(() => UsersApiService(di()));
  di.registerLazySingleton<AuthApiService>(() => AuthApiService(di()));
  di.registerLazySingleton<EventsApiService>(() => EventsApiService(di()));
  di.registerLazySingleton<ChatsApiService>(() => ChatsApiService(di()));
  di.registerLazySingleton<WeatherApiService>(() => WeatherApiService(di()));

  // LOCAL
  di.registerLazySingleton<AuthLocalService>(() => AuthLocalService());
  di.registerLazySingleton<ProfileLocalService>(() => ProfileLocalService(di()));

  // UTILS
  di.registerLazySingleton<MessagingService>(() => MessagingService(di(), di()));
  di.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
}
