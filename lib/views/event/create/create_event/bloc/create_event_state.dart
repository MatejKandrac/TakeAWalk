
part of 'create_event_bloc.dart';

abstract class CreateEventState {
  const CreateEventState();
}

class CreateLoadingState extends CreateEventState {
  const CreateLoadingState();
}

class CreateSuccessState extends CreateEventState {
  const CreateSuccessState();
}

class CreateFormState extends CreateEventState{

  final String? nameError;
  final String? dateError;
  final String? timeFromError;
  final String? timeToError;
  final String? dialogErrorText;
  final String? forecast;
  final bool forecastLoading;
  final List<Location> locations;
  final List<SearchPersonResponse> people;

  const CreateFormState({
    this.nameError,
    this.dateError,
    this.timeFromError,
    this.timeToError,
    this.dialogErrorText,
    this.forecast,
    this.forecastLoading = false,
    this.locations = const [],
    this.people = const []
  });

}

class CreateErrorState extends CreateEventState {
  const CreateErrorState();
}