
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';

part 'register_state.dart';

class RegisterBloc extends Cubit<RegisterState> {
  
  final AuthRepository _authRepository;
  final MessagingService _messagingService;
  
  RegisterBloc(this._authRepository, this._messagingService) : super(const RegisterFormState());

  void register(String username, String email, String password, String confirmPass) async {
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

    var result = await _authRepository.register(RegisterRequest(
        email: email,
        username: username,
        password: password));

    if (result != null) {
      emit(RegisterErrorState(result.getErrorText()));
    } else {
      _messagingService.registerDeviceToken();
      emit(const RegisterSuccessState());
    }
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