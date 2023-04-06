
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterBloc extends Cubit<RegisterState> {
  
  final AuthRepository _authRepository;
  
  RegisterBloc(this._authRepository) : super(const RegisterFormState());

  void register(String username, String email, String password, String confirmPass) {
    String? usernameErr = username.isEmpty ? "This field is required" : null;
    String? emailErr = _validateEmail(email);
    String? passwordErr = password.isEmpty ? "This field is required" : null;
    String? confirmErr = password.isEmpty ? "This field is required" : 
    (password != confirmPass ? "Passwords do not match" : null);
    if (usernameErr != null || emailErr != null || passwordErr != null || confirmErr != null) {
      emit(RegisterFormState(
          usernameError: usernameErr, 
          emailError: emailErr, 
          passwordError: passwordErr, 
          confirmPassError: confirmErr));
      return;
    }
    
    _authRepository.register(RegisterRequest(
        email: email,
        username: username,
        password: password)).fold(
      (left) => emit(RegisterErrorState(left.getErrorText())),
      (right) async {
        var result = await _authRepository.persistAuthData(right.token, right.refreshToken);
        if (!result) {
          emit(const RegisterErrorState("Failed to save data"));
        } else {
          emit(const RegisterSuccessState());
        }
      },
    );
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return "This field is required";
    } else {
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      if (!emailValid) {
        return "Invalid email format";
      }
    }
    return null;
  }
}