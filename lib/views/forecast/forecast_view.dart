
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/weather_response.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:weather_icons/weather_icons.dart';

@RoutePage()
class ForecastPage extends HookWidget {
  const ForecastPage(
      this.dateRange,
      this.location,
      {Key? key}) : super(key: key);

  final String dateRange;
  final Location location;

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<ForecastBloc>(() => di());
    useEffect(() => bloc.getWeather(dateRange, location), const []);
    return BlocProvider<ForecastBloc>(
      create: (context) => bloc,
      child: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Forecast", style: Theme.of(context).textTheme.bodyMedium),
          ),
          body: (state is ForecastLoadingState) ? const Center(
            child: CircularProgressIndicator(),
          ) : SingleChildScrollView(
            child: (state as ForecastResultState).weather.isEmpty ? const Center(
              child: Text("Forecast unavailable"),
            ) : ListView.builder(
              shrinkWrap: true,
              itemCount: state.weather.length,
              itemBuilder: (context, index) => _WeatherDayWidget(state.weather[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherDayWidget extends StatelessWidget {
  const _WeatherDayWidget(this.data, {Key? key}) : super(key: key);

  final WeatherResponse data;

  @override
  Widget build(BuildContext context) {
    var keys = data.data.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.calendar_today, color: Color(0xffF20AB8)),
              const SizedBox(width: 10),
              Text(data.date, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: keys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon((data.data[keys[index]] as String).getIcon()),
                      const SizedBox(height: 5),
                      Text(keys[index], style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 2, color: Colors.white)
        ],
      ),
    );
  }
}

extension WeatherIconFromText on String {

  IconData getIcon() {
    switch(this) {
      case "Sunny": return WeatherIcons.day_sunny;
      case "Overcast": return WeatherIcons.day_sunny_overcast;
      case "Rain": return WeatherIcons.rain;
      case "Fog": return WeatherIcons.fog;
      case "Drizzle": return WeatherIcons.sleet;
      case "Snow": return WeatherIcons.snow;
      case "Thunderstorm": return WeatherIcons.thunderstorm;
    }
    return Icons.question_mark;
  }

}