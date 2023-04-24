import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';

import '../../../domain/models/requests/filter_data.dart';

part 'my_events_state.dart';

class MyEventsBloc extends Cubit<MyEventsState> {
  final EventsRepository repository;

  MyEventsBloc(this.repository) : super(EventsDataState.empty());

  void getEventsData() async {
    repository.getUserEvents().fold((error) => () {}, (data) async {
      emit(EventsDataState(data));
      print(data);
    });
  }

  void filterEvents(FilterData? filterData) async {
    if (filterData == null) return;

    repository
        .filterEvents(filterData).fold(
            (error) => () {},
            (data) async {emit(FilteredDataState(data)); print(data.toList());}
    );
  }

  void emitDataState(List<EventObject> events) async {
    print(events.toList());
    emit(EventsDataState(events));
  }

}
