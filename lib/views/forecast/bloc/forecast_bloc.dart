import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/weather_request.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/weather_response.dart';
import 'package:take_a_walk_app/domain/repositories/weather_repository.dart';

part 'forecast_state.dart';

class ForecastBloc extends Cubit<ForecastState> {

  final WeatherRepository _repository;

  ForecastBloc(this._repository) : super(const ForecastLoadingState());

  getWeather(String dateText, Location location) {
    var split = dateText.split(" - ");
    if (split.length != 2) {
      emit(const ForecastResultState([]));
      return;
    }

    DateTime startDate;
    DateTime endDate;

    try {
      startDate = AppConstants.dateFormat.parse(split[0]);
      endDate = AppConstants.dateFormat.parse(split[1]);
    } catch (e) {
      emit(const ForecastResultState([]));
      return;
    }

    _repository.getWeather(WeatherRequest(
        startDate: AppConstants.weatherDateFormat.format(startDate),
        endDate: AppConstants.weatherDateFormat.format(endDate),
        lat: location.lat,
        lon: location.lon)
    ).fold(
      (left) => emit(const ForecastResultState([])),
      (right) => emit(ForecastResultState(right)),
    );
  }

}