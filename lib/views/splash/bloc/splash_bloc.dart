
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final UsersRepository usersRepository;

  SplashBloc(this.usersRepository) : super(const SplashState("Loading..."));

  checkLoggedIn() async {
    emit(const SplashState(""));
    await storage.deleteAll(); // TODO ONLY FOR DEBUG PURPOSES, REMOVE LATER
    if (await storage.containsKey(key: AppConstants.storageKeyToken)) {
      emit(const SplashState("", continueMain: true));
    } else {
      emit(const SplashState("", continueLogIn: true));
    }
  }

}