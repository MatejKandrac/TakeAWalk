
part of 'invites_bloc.dart';


abstract class InvitesState {

  final List<EventObject> events;

  const InvitesState(this.events);
}

class InvitesDataState extends InvitesState {

  @override
  final List<EventObject> events;

  InvitesDataState(this.events) : super(events);

  factory InvitesDataState.empty() => InvitesDataState([EventObject(name: '', owner: '', eventId: -1, start: DateTime.now(), end: DateTime.now())]);
}

class FilteredInviteDataState extends InvitesState {

  @override
  final List<EventObject> events;

  FilteredInviteDataState(this.events) : super(events);

  factory FilteredInviteDataState.empty() => FilteredInviteDataState([EventObject(name: '', owner: '', eventId: -1, start: DateTime.now(), end: DateTime.now())]);
}

