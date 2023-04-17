
import 'package:dio/dio.dart';
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
  final Dio dio;

  const AuthRepositoryImpl({
    required this.apiService,
    required this.localService,
    required this.dio
  });

  @override
  Future<RequestError?> login(LoginRequest request) async {
    var result = await makeRequest(request: () => apiService.login(request));
    if (result.isRight) {
      var saveResult = await persistAuthData(result.right);
      if (!saveResult) {
        return const RequestError.custom("Unable to save data");
      } else {
        dio.options.headers = {'Authorization': 'Bearer ${result.right.token}'};
        return null;
      }
    }
    return result.left;
  }

  @override
  Future<RequestError?> refreshToken(String refreshToken) async {
    var result = await makeRequest(request: () => apiService.refreshToken(refreshToken));
    if (result.isRight) {
      var saveResult = await persistAuthData(result.right);
      if (!saveResult) {
        return const RequestError.custom("Unable to save data");
      } else {
        dio.options.headers = {'Authorization': 'Bearer ${result.right.token}'};
        return null;
      }
    }
    return result.left;
  }

  @override
  Future<RequestError?> register(RegisterRequest request) async {
    var result = await makeRequest(request: () => apiService.register(request));
    if (result.isRight) {
      var saveResult = await persistAuthData(result.right);
      if (!saveResult) {
        return const RequestError.custom("Unable to save data");
      } else {
        dio.options.headers = {'Authorization': 'Bearer ${result.right.token}'};
        return null;
      }
    }
    return result.left;
  }

  @override
  Future<bool> persistAuthData(AuthResponse data) {
    return localService.persistData(data.token, data.refreshToken);
  }

  @override
  Future<RequestError?> sendDeviceToken(int userId, String deviceToken) {
    return makeRequest(request: () => apiService.sendDeviceToken(userId, deviceToken)).fold(
            (left) => left,
            (right) => null
    );
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