

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/weather/weather_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/weather_request.dart';
import 'package:take_a_walk_app/domain/models/responses/weather_response.dart';
import 'package:take_a_walk_app/domain/repositories/weather_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

class WeatherRepositoryImpl extends BaseApiRepository implements WeatherRepository {

  final WeatherApiService service;

  const WeatherRepositoryImpl(this.service);

  @override
  Future<Either<RequestError, List<WeatherResponse>>> getWeather(WeatherRequest request) {
    return makeRequest(request: () => service.getWeather(request));
  }

}