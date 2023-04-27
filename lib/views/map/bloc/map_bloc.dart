
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/location_getter_mixin.dart';

import '../../../domain/models/responses/event_response.dart';

part 'map_state.dart';

class MapBloc extends Cubit<MapState> with LocationMixin {
  final EventsRepository repository;

  MapBloc(this.repository) : super(const MapDataState(locationData: [], loading: true));

  List<MapEventObj> mapEvents = [];

  void getMapLocationData() async {
    repository.getMapEvents().fold(
        (error) => emit(MapErrorState(error.getErrorText())),
        (data) async {
          mapEvents = data;
          emit(MapDataState(locationData: data));
        }
    );
  }

  void onCenterGps() async {
    emit(MapDataState(locationData: mapEvents, loading: true));
    getPosition().then((value) {
      if (value != null) {
        emit(MapDataState(locationData: mapEvents, loading: true, gpsPosition: LatLng(value.latitude, value.longitude)));
      }
    }).onError((error, stackTrace) {
      emit(MapDataState(locationData: mapEvents));
      emit(const MapErrorState("Could not get location"));
    });
  }

}