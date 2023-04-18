
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';

part 'create_event_state.dart';

class CreateEventBloc extends Cubit<CreateEventState> {

  final EventsRepository _repository;

  CreateEventBloc(this._repository) : super(const CreateFormState());

  final List<Location> _locations = [];
  final List<ProfileResponse> _profiles = [];


  addLocation(Location location) {
    _locations.add(location);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

  addPerson(ProfileResponse value) {
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

  deletePerson(ProfileResponse person) {
    _profiles.remove(person);
    emit(CreateFormState(locations: _locations, people: _profiles));
  }

}