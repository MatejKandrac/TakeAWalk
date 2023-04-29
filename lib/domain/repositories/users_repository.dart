import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../models/requests/profile_edit_request.dart';

abstract class UsersRepository {

  Future<Either<RequestError, ProfileResponse>> getProfile();

  Future<Either<RequestError, String>> editUserProfile(ProfileEditRequest request);

  Future<Either<RequestError, List<SearchPersonResponse>>> search(String username);

  Future<Either<RequestError, String>> deleteDeviceToken();

  Future<RequestError?> updateProfileImage(File file);

}