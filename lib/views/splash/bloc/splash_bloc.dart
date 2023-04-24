
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final UsersRepository usersRepository;
  final MessagingService messagingService;
  final Dio dio;

  SplashBloc({
    required this.usersRepository,
    required this.messagingService,
    required this.dio
  }) : super(const SplashState("Loading..."));

  checkLoggedIn() async {
    emit(const SplashState(""));
    await storage.deleteAll(); // TODO ONLY FOR DEBUG PURPOSES, REMOVE LATER
    var token = await storage.read(key: AppConstants.storageKeyToken);
    if (token != null) {
      dio.options.headers = {'Authorization': 'Bearer $token'};
      messagingService.registerDeviceToken();
      emit(const SplashState("", continueMain: true));
    } else {
      emit(const SplashState("", continueLogIn: true));
    }
  }

}