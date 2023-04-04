
part of '../../splash/bloc/splash_bloc.dart';

class SplashState {

  final String loadingText;
  final bool continueLogIn;
  final bool continueMain;

  const SplashState(
      this.loadingText, {
        this.continueLogIn = false,
        this.continueMain = false
      });

}
