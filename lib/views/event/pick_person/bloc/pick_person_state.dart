
part of 'pick_person_bloc.dart';

abstract class PickPersonState {
  const PickPersonState();
}

class PickPersonErrorState extends PickPersonState {
  final String text;
  const PickPersonErrorState(this.text);
}

class PickPersonListState extends PickPersonState {
  final List<SearchPersonResponse> people;
  final SearchPersonResponse? selected;
  const PickPersonListState([this.people = const [], this.selected]);
}

class PickPersonLoadingState extends PickPersonState {
  const PickPersonLoadingState();
}