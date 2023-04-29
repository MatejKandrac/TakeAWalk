import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/local/profile_local_service.dart';
import 'package:take_a_walk_app/data/datasource/remote/users/users_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../../domain/models/requests/profile_edit_request.dart';

class UsersRepositoryImpl extends BaseApiRepository implements UsersRepository {
  final UsersApiService _usersApiService;
  final ProfileLocalService profileLocalService;
  final AuthRepository _authRepository;

  const UsersRepositoryImpl(this._usersApiService, this._authRepository, this.profileLocalService);

  @override
  Future<Either<RequestError, ProfileResponse>> getProfile() async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }

    var response = await makeRequest<ProfileResponse>(
      request: () => _usersApiService.getProfile(userId),
      localRequest: () => profileLocalService.getProfile(userId)
    );

    if (response.isRight) {

      print('It is right');

      var isPresent = await profileLocalService.isPresent(userId);

      if (isPresent) {
        profileLocalService.updateProfile(userId, response.right);
      } else {
        profileLocalService.saveProfile(response.right, userId);
      }
    }

    return response;
  }

  @override
  Future<Either<RequestError, String>> editUserProfile(ProfileEditRequest request) async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }

    return makeRequest<String>(request: () => _usersApiService.editUserProfile(userId, request));
  }

  @override
  Future<Either<RequestError, List<SearchPersonResponse>>> search(String username) async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }
    return makeRequest<List<SearchPersonResponse>>(request: () => _usersApiService.searchPerson(userId, username));
  }

  @override
  Future<Either<RequestError, String>> deleteDeviceToken() async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }

    return makeRequest<String>(request: () => _usersApiService.deleteDeviceToken(userId));
  }

  Future<void> deleteDatabase() async {
    await profileLocalService.deleteDatabase();
  }
}
