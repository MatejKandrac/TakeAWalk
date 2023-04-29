part of 'map_bloc.dart';

abstract class MapState {
  const MapState();
}

class MapDataState extends MapState {
  final MapController controller;
  final List<MapEventObj> locationData;
  final LatLng? userLocation;
  final bool loading;

  const MapDataState({required this.controller, required this.locationData, this.loading = false, this.userLocation});

}

class MapLoadingState extends MapState {
  const MapLoadingState();
}

class MapErrorState extends MapState {
  final String text;
  const MapErrorState(this.text);
}