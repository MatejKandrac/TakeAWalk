
// import '../../../domain/models/responses/event_response.dart';

part of 'my_events_bloc.dart';

abstract class MyEventsState {

  final List<EventObject> events;

  const MyEventsState(this.events);
}

class EventsDataState extends MyEventsState {

  @override
  final List<EventObject> events;

  EventsDataState(this.events) : super(events);

  factory EventsDataState.empty() => EventsDataState([EventObject(name: '', owner: '', eventId: -1, start: DateTime.now(), end: DateTime.now())]);
}

class FilteredDataState extends MyEventsState {

  @override
  final List<EventObject> events;

  FilteredDataState(this.events): super(events);

  factory FilteredDataState.empty() => FilteredDataState([EventObject(name: '', owner: '', eventId: -1, start: DateTime.now(), end: DateTime.now())]);
}