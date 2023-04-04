
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:take_a_walk_app/config/constants.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {

  FlutterSecureStorage storage = const FlutterSecureStorage();
  SplashBloc() : super(const SplashState("Loading..."));

  checkLoggedIn() async {
    if (await storage.containsKey(key: AppConstants.storageKeyToken)) {
      emit(const SplashState("", continueMain: true));
      return;
    }
    emit(const SplashState("", continueLogIn: true));
  }

}