import 'package:floor/floor.dart';

import '../entities/event.dart';

@dao
abstract class EventDao {

  @Query('SELECT * FROM Event;')
  Future<List<Event>> getAllUserEvents();

  @Query('UPDATE Event SET id = :id, name = :name, owner = :owner, start = :start, end = :end, people = :people, places = :places, eventId = :eventId WHERE eventId = :eventId ;')
  Future<void> updateEvent(int id, String name, String owner, String start, String end, int people, int places, int eventId);

  @Query('SELECT * FROM Event WHERE eventId = :eventId ;')
  Future<Event?> isPresent(int eventId);

  @Query('DELETE FROM Event WHERE eventId = :eventId ;')
  Future<void> deleteEvent(int eventId);
  
  @insert
  Future<void> insertEvent(Event event);
}