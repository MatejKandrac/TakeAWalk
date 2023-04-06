
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';

part 'users_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl, parser: Parser.MapSerializable)
abstract class UsersApiService {
  factory UsersApiService(Dio dio, {String baseUrl}) = _UsersApiService;

  @GET('/v1/user/{user_id}/profile')
  Future<HttpResponse<ProfileResponse>> getProfile(@Path('user_id') int userId);
}