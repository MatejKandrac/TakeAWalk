
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/users/users_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../../domain/models/requests/profile_edit_request.dart';

class UsersRepositoryImpl extends BaseApiRepository implements UsersRepository {

  final UsersApiService _usersApiService;
  final AuthRepository _authRepository;

  const UsersRepositoryImpl(this._usersApiService, this._authRepository);

  @override
  Future<Either<RequestError, ProfileResponse>> getProfile() async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return const Left(RequestError.badRequest);
    }
    return makeRequest<ProfileResponse>(request: () => _usersApiService.getProfile(userId));
  }

  @override
  Future<Either<RequestError, String>> editUserProfile(ProfileEditRequest request) async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return const Left(RequestError.badRequest);
    }
    return makeRequest<String>(request: () => _usersApiService.editUserProfile(userId, request));
  }

}