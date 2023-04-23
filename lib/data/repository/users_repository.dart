
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:take_a_walk_app/data/datasource/remote/users/users_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

import '../../domain/models/requests/profile_edit_request.dart';

class UsersRepositoryImpl extends BaseApiRepository implements UsersRepository {

  final UsersApiService _usersApiService;
  final AuthRepository _authRepository;

  const UsersRepositoryImpl(this._usersApiService, this._authRepository);

  @override
  Future<Either<RequestError, ProfileResponse>> getProfile() async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }
    return makeRequest<ProfileResponse>(request: () => _usersApiService.getProfile(userId));
  }

  @override
  Future<Either<RequestError, String>> editUserProfile(ProfileEditRequest request) async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }

    // try {
    //   // TODO encrypt the password
    //   if (request.password != null) {
    //     var encryptedPassword = await FlutterBcrypt.hashPw(password: request.password!, salt: '');
    //     request.password = encryptedPassword;
    //     print(encryptedPassword);
    //   }
    // } on PlatformException {
    //   print("error");
    // }

    return makeRequest<String>(request: () => _usersApiService.editUserProfile(userId, request));
  }

  @override
  Future<Either<RequestError, List<SearchPersonResponse>>> search(String username) {
    return makeRequest<List<SearchPersonResponse>>(request: () => _usersApiService.searchPerson(username));
  }

  @override
  Future<Either<RequestError, String>> deleteDeviceToken() async {
    var userId = await _authRepository.getUserId();
    if (userId == null) {
      return Left(RequestError.badRequest());
    }

    return makeRequest<String>(request: () => _usersApiService.deleteDeviceToken(userId));
  }

}