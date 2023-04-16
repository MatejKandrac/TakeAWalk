import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class AuthRepository {

  Future<Either<RequestError, AuthResponse>> login(LoginRequest request);

  Future<Either<RequestError, AuthResponse>> register(RegisterRequest request);

  Future<Either<RequestError, AuthResponse>> refreshToken(String refreshToken);

  Future<Either<RequestError, dynamic>> sendDeviceToken(int userId, String deviceToken);

  Future<bool> persistAuthData(String token, String refreshToken);

  Future<String?> getToken();

  Future<int?> getUserId();

}