
part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginFormState extends LoginState{

  final String? initialEmail;
  final String? emailError;
  final String? passwordError;

  const LoginFormState({
    this.initialEmail,
    this.emailError,
    this.passwordError
  });
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}
