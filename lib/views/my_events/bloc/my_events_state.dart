
part of 'my_events_bloc.dart';

abstract class MyEventsState {

  final List<EventObject> events;

  const MyEventsState(this.events);
}

class EventsDataState extends MyEventsState {

  @override
  final List<EventObject> events;

  EventsDataState(this.events) : super(events);

  factory EventsDataState.empty() => EventsDataState([]);
}

class FilteredDataState extends MyEventsState {

  @override
  final List<EventObject> events;

  FilteredDataState(this.events): super(events);

  factory FilteredDataState.empty() => FilteredDataState([]);
}