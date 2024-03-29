
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';

import '../../../../domain/models/requests/profile_edit_request.dart';

part 'users_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class UsersApiService {
  factory UsersApiService(Dio dio, {String baseUrl}) = _UsersApiService;

  @GET('/v1/user/{user-id}/profile')
  Future<HttpResponse<ProfileResponse>> getProfile(@Path('user-id') int userId);

  @PUT('/v1/user/{user-id}/edit')
  Future<HttpResponse<String>> editUserProfile(@Path('user-id') int userId, @Body() ProfileEditRequest request);

  @PUT('/v1/user/{user-id}/profile-picture')
  Future<HttpResponse<String>> editUserProfilePicture(@Path('user-id') int userId, MultipartFile file);

  @DELETE('/v1/user/{user-id}/device-token')
  Future<HttpResponse<String>> deleteDeviceToken(@Path('user-id') int userId);

  @GET('/v1/user/{user-id}/search')
  Future<HttpResponse<List<SearchPersonResponse>>> searchPerson(
      @Path('user-id') int userId,
      @Query('username') String username);

  @PUT('/v1/user/{user-id}/profile-picture')
  @MultiPart()
  Future<HttpResponse<String>> updateProfilePicture(@Path('user-id') int userId, @Part(name: 'file') File file);
}