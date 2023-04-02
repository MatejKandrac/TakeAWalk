
part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginFormState extends LoginState{

  final String? initialUsername;

  const LoginFormState({
    this.initialUsername
  });
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}