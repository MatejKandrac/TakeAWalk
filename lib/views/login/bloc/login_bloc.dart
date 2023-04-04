
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {

  final UsersRepository repository;

  LoginBloc(this.repository) : super(const LoginFormState());

  void login(String email, String password) async {

    // repository.getProfile(2).fold((left) => print(left), (right) => print(right));
    // repository.logIn(LoginRequest(email: email, password: password)).fold(
    //     (error) {print(error);},
    //     (data) {}
    // );
    emit(const LoginLoadingState());
    await Future.delayed(const Duration(seconds: 2)); // do work
    emit(const LoginSuccessState());
  }

}