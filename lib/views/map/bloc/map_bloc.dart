
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';

import '../../../domain/models/responses/event_response.dart';

part 'map_state.dart';

class MapBloc extends Cubit<MapState> {
  final EventsRepository repository;

  MapBloc(this.repository) : super(MapDataState.empty());


  void getMapLocationData() async {
    repository.getMapEvents().fold(
        (error) => () {},
        (data) async {
          emit(MapDataState(locationData: data));
          print(data.toList());
        }
    );
  }

}