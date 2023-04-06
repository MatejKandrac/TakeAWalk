
part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginFormState extends LoginState{

  final bool emailError;
  final bool passwordError;

  const LoginFormState({
    this.emailError = false,
    this.passwordError = false
  });
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

class LoginErrorState extends LoginState {
  final String errorText;
  const LoginErrorState(this.errorText);
}