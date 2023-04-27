part of 'map_bloc.dart';

abstract class MapState {
  const MapState();
}

class MapDataState extends MapState {
  final List<MapEventObj> locationData;
  final LatLng? gpsPosition;
  final bool loading;

  const MapDataState({required this.locationData, this.gpsPosition, this.loading = false});

  factory MapDataState.empty() => const MapDataState(locationData: []);
}

class MapErrorState extends MapState {
  final String text;
  const MapErrorState(this.text);
}