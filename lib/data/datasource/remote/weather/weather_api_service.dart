

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/domain/models/requests/weather_request.dart';
import 'package:take_a_walk_app/domain/models/responses/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class WeatherApiService {

  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("/v1/weather")
  Future<HttpResponse<List<WeatherResponse>>> getWeather(@Body() WeatherRequest request);

}