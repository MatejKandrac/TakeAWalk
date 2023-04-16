
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/local/auth_local_service.dart';
import 'package:take_a_walk_app/data/datasource/remote/auth/auth_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

class AuthRepositoryImpl extends BaseApiRepository implements AuthRepository {

  final AuthApiService apiService;
  final AuthLocalService localService;

  const AuthRepositoryImpl({
    required this.apiService,
    required this.localService
  });

  @override
  Future<Either<RequestError, AuthResponse>> login(LoginRequest request) {
    return makeRequest(request: () => apiService.login(request));
  }

  @override
  Future<bool> persistAuthData(String token, String refreshToken) {
    return localService.persistData(token, refreshToken);
  }

  @override
  Future<Either<RequestError, AuthResponse>> refreshToken(String refreshToken) {
    return makeRequest(request: () => apiService.refreshToken(refreshToken));
  }

  @override
  Future<Either<RequestError, AuthResponse>> register(RegisterRequest request) {
    return makeRequest(request: () => apiService.register(request));
  }

  @override
  Future<Either<RequestError, dynamic>> sendDeviceToken(int userId, String deviceToken) async {
    String? token = await getToken();
    if (token == null) {
      return const Left(RequestError.unauthenticated);
    }
    print(token);
    return makeRequest(request: () => apiService.sendDeviceToken(userId, "Bearer $token", deviceToken));
  }

  @override
  Future<String?> getToken() {
    return localService.getToken();
  }

  @override
  Future<int?> getUserId() {
    return localService.getUserId();
  }

}