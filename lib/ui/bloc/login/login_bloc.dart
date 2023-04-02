
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {

  final UsersRepository repository;

  LoginBloc(this.repository) : super(const LoginFormState());

  void login(String email, String password) {
    repository.logIn(LoginRequest(email: email, password: password));
  }

}