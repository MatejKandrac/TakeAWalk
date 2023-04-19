
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/create_event_data.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';

part 'create_event_state.dart';

class CreateEventBloc extends Cubit<CreateEventState> {

  final EventsRepository _repository;

  CreateEventBloc(this._repository) : super(const CreateFormState());

  final List<Location> _locations = [];
  final List<SearchPersonResponse> _profiles = [];


  addLocation(Location location) {
    _locations.add(location);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  addPerson(SearchPersonResponse value) {
    _profiles.add(value);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  deleteLocation(Location location) {
    _locations.remove(location);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Location item = _locations.removeAt(oldIndex);
    _locations.insert(newIndex, item);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  deletePerson(SearchPersonResponse person) {
    _profiles.remove(person);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  void createEvent(String name, String date, String timeStartText, String timeEndText) {
    emit(const CreateLoadingState());
    // Check for errors
    String? nameError;
    String? dateError;
    String? timeStartError;
    String? timeEndError;
    late DateTime dateStart;
    late DateTime dateEnd;
    DateTime? timeStart;
    DateTime? timeEnd;

    if (name.isEmpty) {
      nameError = "This field is required";
    }
    if (timeStartText.isEmpty) {
      timeStartError = "This field is required";
    } else {
      try {
        timeStart = AppConstants.timeFormat.parse(timeStartText);
      } catch (e) {
        timeStartError = "Invalid format";
      }
    }

    if (timeEndText.isEmpty) {
      timeEndError = "This field is required";
    } else {
      try {
        timeEnd = AppConstants.timeFormat.parse(timeEndText);
      } catch (e) {
        timeEndError = "Invalid format";
      }
    }

    if (date.isEmpty) {
      dateError = "This field is required";
    } else {
      var split = date.split(' - ');
      if (split.length != 2) {
        dateError = "Invalid format, use dd.MM.yyyy";
      } else {
        try {
          dateStart = AppConstants.dateFormat.parse(split[0]);
          dateEnd = AppConstants.dateFormat.parse(split[1]);
          if (timeStart != null && timeEnd != null) {
            dateStart = dateStart.copyWith(
                hour: timeStart.hour,
                minute: timeStart.minute
            );
            dateEnd = dateEnd.copyWith(
                hour: timeEnd.hour,
                minute: timeEnd.minute
            );
            if (dateEnd.isBefore(dateStart)) {
              dateError = "End is before start";
            }
          }
        } catch (e) {
          dateError = "Invalid format, use dd.MM.yyyy";
        }
      }
    }

    if (nameError != null || timeEndError != null || timeStartError != null || dateError != null) {
      emit(CreateFormState(
        nameError: nameError,
        dateError: dateError,
        timeFromError: timeStartError,
        timeToError: timeEndError,
        people: _profiles,
        locations: _locations
      ));
      return;
    }

    // Check for missing people or locations
    if (_locations.isEmpty) {
      emit(CreateFormState(
          people: _profiles,
          locations: _locations,
          dialogErrorText: "At least one location is required"
      ));
      return;
    }
    if (_profiles.isEmpty) {
      emit(CreateFormState(
          people: _profiles,
          locations: _locations,
          dialogErrorText: "At least one person is required"
      ));
      return;
    }

    var locationData = <LocationData>[];
    for (int i = 0; i < _locations.length; i++) {
      var location = _locations[i];
      locationData.add(LocationData(
          lat: location.lat,
          lon: location.lon,
          name: location.name,
          order: i)
      );
    }
    _repository.createEvent(CreateEventData(
        start: dateStart,
        end: dateEnd,
        name: name,
        users: _profiles.map((e) => e.id).toList(),
        locations: locationData
    )).fold(
      (left) => emit(CreateErrorState()),
      (right) => emit(CreateSuccessState()),
    );

  }

}