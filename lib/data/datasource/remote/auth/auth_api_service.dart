
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/domain/models/requests/device_token_request.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/requests/register_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';

part 'auth_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class AuthApiService {

  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/auth/login')
  Future<HttpResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<HttpResponse<AuthResponse>> register(@Body() RegisterRequest request);

  @POST('/auth/refresh')
  Future<HttpResponse<AuthResponse>> refreshToken(@Body() String refreshToken);

  @POST('/v1/user/{user_id}/device-token')
  Future<HttpResponse<String>> sendDeviceToken(@Path('user_id') int userId, @Body() DeviceTokenRequest request);
}