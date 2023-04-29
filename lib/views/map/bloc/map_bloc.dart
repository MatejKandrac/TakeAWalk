
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/location_getter_mixin.dart';

import '../../../domain/models/responses/event_response.dart';

part 'map_state.dart';

class MapBloc extends Cubit<MapState> with LocationMixin {
  final EventsRepository repository;

  MapBloc(this.repository) : super(const MapLoadingState()){
    _controller = MapController();
  }

  List<MapEventObj> mapEvents = [];
  late MapController _controller;

  void getMapLocationData() async {
    repository.getMapEvents().fold(
        (error) => emit(MapErrorState(error.getErrorText())),
        (data) async {
          mapEvents = data;
          emit(MapDataState(locationData: data, controller: _controller));
        }
    );
  }

  void onCenterGps() async {
    emit(MapDataState(controller: _controller, locationData: mapEvents, loading: true));
    getPosition().then((value) {
      if (value != null) {
        var position = LatLng(value.latitude, value.longitude);
        _controller.move(position, 14);
        emit(MapDataState(controller: _controller, locationData: mapEvents, userLocation: position));
      }
    }).onError((error, stackTrace) {
      emit(MapDataState(controller: _controller, locationData: mapEvents));
      emit(const MapErrorState("Could not get location"));
    });
  }

}