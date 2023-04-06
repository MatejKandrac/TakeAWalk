
part of 'register_bloc.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterFormState extends RegisterState{

  final String? usernameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPassError;

  const RegisterFormState({
    this.usernameError,
    this.emailError,
    this.passwordError,
    this.confirmPassError
  });

}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterErrorState extends RegisterState {
  final String error;
  const RegisterErrorState(this.error);
}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState();
}