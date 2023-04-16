
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {

  final AuthRepository repository;
  final MessagingService messagingService;

  LoginBloc(this.repository, this.messagingService) : super(const LoginFormState());

  void login(String email, String password) async {
    emit(const LoginLoadingState());
    var mailEmpty = email.isEmpty;
    var passEmpty = password.isEmpty;
    if (mailEmpty || passEmpty) {
      emit(LoginFormState(
        emailError: mailEmpty,
        passwordError: passEmpty
      ));
      return;
    }
    repository.login(LoginRequest(email: email, password: password)).fold(
        (error) => emit(LoginErrorState(error.getErrorText())),
        (data) async {
          var result = await repository.persistAuthData(data.token, data.refreshToken);
          if (result) {
            messagingService.registerDeviceToken();
            emit(const LoginSuccessState());
          } else {
            emit(const LoginErrorState("Unable to save login data"));
          }
        }
    );
  }

}