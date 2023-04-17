
part of 'create_event_bloc.dart';

abstract class CreateEventState {
  const CreateEventState();
}

class CreateFormState extends CreateEventState{

  final String? nameError;
  final String? dateError;
  final String? timeFromError;
  final String? timeToError;
  final String? dialogErrorText;
  final List<Location> locations;
  final List<ProfileResponse> people;

  const CreateFormState({
    this.nameError,
    this.dateError,
    this.timeFromError,
    this.timeToError,
    this.dialogErrorText,
    this.locations = const [],
    this.people = const []
  });

}