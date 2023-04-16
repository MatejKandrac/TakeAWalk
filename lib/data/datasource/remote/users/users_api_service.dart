
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';

import '../../../../domain/models/requests/profile_edit_request.dart';

part 'users_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl, parser: Parser.MapSerializable)
abstract class UsersApiService {
  factory UsersApiService(Dio dio, {String baseUrl}) = _UsersApiService;

  @GET('/v1/user/{user-id}/profile')
  Future<HttpResponse<ProfileResponse>> getProfile(@Path('user-id') int userId);

  @PUT('/v1/user/{user-id}/edit')
  Future<HttpResponse<String>> editUserProfile(@Path('user-id') int userId, @Body() ProfileEditRequest request);

  @PUT('/v1/user/{user-id}/profile-picture')
  Future<HttpResponse<String>> editUserProfilePicture(@Path('user-id') int userId, MultipartFile file);
}