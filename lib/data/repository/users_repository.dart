
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/users_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

class UsersRepositoryImpl extends BaseApiRepository implements UsersRepository {

  final UsersApiService _usersApiService;

  const UsersRepositoryImpl(this._usersApiService);

  @override
  Future<Either<RequestError, AuthResponse>> logIn(LoginRequest request) async {
    return makeRequest<AuthResponse>(request: () => _usersApiService.login(request));
  }

  @override
  Future<Either<RequestError, ProfileResponse>> getProfile(int id) {
    return makeRequest<ProfileResponse>(request: () => _usersApiService.getProfile(id));
  }

}