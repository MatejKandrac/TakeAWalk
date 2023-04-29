
part of 'event_edit_bloc.dart';

class EventEditState {

  final String? dateError;
  final String? timeStartError;
  final String? timeEndError;

  final bool? updateState;

  final List<Location> locations;
  final List<EventPersonResponse> people;
  final List<PictureResponse>? pictures;

  const EventEditState({
    required this.locations,
    required this.people,
    this.pictures,
    this.dateError,
    this.timeEndError,
    this.timeStartError,
    this.updateState
  });

  factory EventEditState.empty() => const EventEditState(locations: [], people: []);
}

