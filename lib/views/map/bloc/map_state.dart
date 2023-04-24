part of 'map_bloc.dart';

abstract class MapState {
  final List<MapEventObj> locationData;

  const MapState(this.locationData);
}

class MapDataState extends MapState {
  final List<MapEventObj> locationData;

  MapDataState({required this.locationData}) : super(locationData);

  factory MapDataState.empty() =>
      MapDataState(locationData: [
        MapEventObj(lat: -1,
            lon: -1,
            name: '',
            dateStart: DateTime.now(),
            dateEnd: DateTime.now(),
            eventId: -1)
      ]);
}
