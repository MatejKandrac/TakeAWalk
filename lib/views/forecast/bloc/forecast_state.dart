
part of 'forecast_bloc.dart';

abstract class ForecastState {
  const ForecastState();
}

class ForecastLoadingState extends ForecastState {
  const ForecastLoadingState();
}

class ForecastResultState extends ForecastState {

  final List<WeatherResponse> weather;

  const ForecastResultState(this.weather);
}