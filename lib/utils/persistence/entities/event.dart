import 'package:floor/floor.dart';

@entity
class Event {

  @primaryKey
  final int id;

  final String name;

  final String owner;

  final String start;

  final String end;

  final int people;

  final int places;

  final int eventId;

  Event(
      {required this.id,
      required this.name,
      required this.owner,
      required this.start,
      required this.end,
      required this.people,
      required this.places,
      required this.eventId});
}
