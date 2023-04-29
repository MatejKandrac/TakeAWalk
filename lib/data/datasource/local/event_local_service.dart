import 'package:intl/intl.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/filter_data.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/utils/persistence/app_database.dart';
import 'package:take_a_walk_app/utils/persistence/entities/event.dart';

class EventLocalService {
  final AppDatabase database;

  EventLocalService(this.database);

  Future<List<EventObject>> getAllUserEvents(bool showHistory) async {
    final eventDao = database.eventDao;

    var events = await eventDao.getAllUserEvents();

    List<EventObject> eventObjects = [];

    events.forEach((event) {
      eventObjects.add(EventObject(
          name: event.name,
          owner: event.owner,
          start: DateTime.parse(event.start),
          end: DateTime.parse(event.end),
          peopleGoing: event.people,
          places: event.places,
          eventId: event.eventId));
      print(event.eventId);
    });

    if (!showHistory) {
      eventObjects = eventObjects.where((event) => event.end.isAfter(DateTime.now())).toList();
    }

    return eventObjects;
  }


  Future<List<EventObject>> filterUserEvents(int id, FilterData filter) async {

    List<EventObject> events = await getAllUserEvents(filter.showHistory);

    events = events.where((event) => event.places! >= filter.places).toList();

    events = events.where((event) => event.peopleGoing! >= filter.peopleGoing).toList();

    if (filter.date != null) {
      // events = events.where((event) => DateFormat('dd-MM-yyyy', event.start.toString()) == DateFormat('dd-MM-yyyy', filter.date.toString())).toList();
      events = events.where((event) => AppConstants.dateOnlyFormat.format(event.start).toString() == AppConstants.dateOnlyFormat.format(filter.date!).toString()).toList();
    }

    if (filter.order == 'name') {
      events.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter.order == 'date') {
      events.sort((a, b) => a.start.toIso8601String().compareTo(b.start.toIso8601String()));
    } else if (filter.order == 'time') {
      print(AppConstants.timeFormat.format(events.first.start));
      events.sort((a, b) => AppConstants.timeFormat.format(a.start).compareTo(AppConstants.timeFormat.format(b.start)));

    }

    return events;
  }


  void saveEvent(EventObject eventData) {
    final eventDao = database.eventDao;

    var event = Event(
        id: eventData.eventId,
        name: eventData.name,
        owner: eventData.owner,
        start: eventData.start.toString(),
        end: eventData.end.toString(),
        people: eventData.peopleGoing!,
        places: eventData.places!,
        eventId: eventData.eventId);

    eventDao.insertEvent(event);

  }

  void updateEvent(EventObject eventData) async {
    final eventDao = database.eventDao;

    print(eventData.eventId);

    var newEvent = Event(
        id: eventData.eventId,
        name: eventData.name,
        owner: eventData.owner,
        start: eventData.start.toString(),
        end: eventData.end.toIso8601String(),
        people: eventData.peopleGoing ?? 0,
        places: eventData.places ?? 0,
        eventId: eventData.eventId);

    eventDao.deleteEvent(eventData.eventId);
    eventDao.insertEvent(newEvent);

    // await eventDao.updateEvent(eventData.eventId,
    //     eventData.name,
    //     eventData.owner,
    //     eventData.start.toString(),
    //     eventData.end.toIso8601String(),
    //     eventData.peopleGoing ?? 0,
    //     eventData.places ?? 0,
    //     eventData.eventId);

    var newDbEvent = await eventDao.isPresent(eventData.eventId);
    print('This is new end ${newDbEvent!.end}');
  }

  Future<bool> isPresent(int id) async {
    final eventDao = database.eventDao;

    var event = await eventDao.isPresent(id);

    if (event != null) {
      return true;
    } else {
      return false;
    }
  }

}
