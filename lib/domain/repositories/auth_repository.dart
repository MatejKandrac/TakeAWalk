import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class AuthRepository {

  Future<RequestError?> login(LoginRequest request);

  Future<RequestError?> register(RegisterRequest request);

  Future<RequestError?> refreshToken(String refreshToken);

  Future<RequestError?> sendDeviceToken(int userId, String deviceToken);

  Future<bool> persistAuthData(AuthResponse authResponse);

  Future<String?> getToken();

  Future<int?> getUserId();

}