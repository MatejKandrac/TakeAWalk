import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';

part 'users_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl, parser: Parser.MapSerializable)
abstract class UsersApiService {
  factory UsersApiService(Dio dio, {String baseUrl}) = _UsersApiService;

  @POST('/auth/login')
  Future<HttpResponse<AuthResponse>> login(@Body() LoginRequest loginRequest);
}