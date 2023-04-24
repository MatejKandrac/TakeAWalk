
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/requests/weather_request.dart';
import 'package:take_a_walk_app/domain/models/responses/weather_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class WeatherRepository {

  Future<Either<RequestError, List<WeatherResponse>>> getWeather(WeatherRequest request);

}