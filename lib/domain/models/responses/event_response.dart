import 'profile_response.dart';

class EventResponse {
  final int id;
  final String name;
  final DateTime dateStart;
  final DateTime dateEnd;
  final Status status;
  final ProfileResponse owner;
  final List<Location> locations;
  final List<ProfileResponse> profiles;

  const EventResponse(
      {required this.id,
      required this.name,
      required this.owner,
      required this.dateStart,
      required this.dateEnd,
      required this.status,
      required this.locations,
      required this.profiles});

  factory EventResponse.fromMap(Map<String, dynamic> map) {
    return EventResponse(
      id: map['id'] as int,
      name: map['name'] as String,
      owner: map['owner'] as ProfileResponse,
      dateStart: map['dateStart'] as DateTime,
      dateEnd: map['dateEnd'] as DateTime,
      status: map['status'] as Status,
      locations: map['locations'] as List<Location>,
      profiles: map['profiles'] as List<ProfileResponse>,
    );
  }
}

class Location {
  final double lat;
  final double lon;
  final String name;

  const Location({required this.lat, required this.lon, required this.name});
}

enum Status {
  ACCEPTED,
  DECLINED,
  PENDING;
}

class EventObject {
  final String name;
  final String owner;
  final DateTime? start;
  final DateTime? end;
  final int? peopleGoing;
  final int? places;
  final int eventId;

  const EventObject({
    required this.name,
    required this.owner,
    this.start,
    this.end,
    this.peopleGoing,
    this.places,
    required this.eventId,
  });

  factory EventObject.fromMap(Map<String, dynamic> map) {
    return EventObject(
      name: map['name'] as String,
      owner: map['owner'] as String,
      start: map['start'] as DateTime?,
      end: map['end'] as DateTime?,
      peopleGoing: map['peopleGoing'] as int?,
      places: map['places'] as int?,
      eventId: map['eventId'] as int,
    );
  }

}

class EventData {
  final String eventHost;
  final List<String>? eventPeople;
  final List<LocationObject> eventLocations;
  final EventTimeDetailObj eventTime;
  final String? eventStatus;

  const EventData({
    required this.eventHost,
    this.eventPeople,
    required this.eventLocations,
    required this.eventTime,
    this.eventStatus,
  });

  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      eventHost: map['eventHost'] as String,
      eventPeople: map['eventPeople'] as List<String>?,
      eventLocations: map['eventLocations'] as List<LocationObject>,
      eventTime: map['eventTime'] as EventTimeDetailObj,
      eventStatus: map['eventStatus'] as String?,
    );
  }

}

class LocationObject {
  final String? name;
  final double? latitude;
  final double? longitude;
  final int? order;
  final bool? visited;

  const LocationObject(
      {this.name, this.latitude, this.longitude, this.order, this.visited});
}

class EventTimeDetailObj {
  final DateTime? start;
  final DateTime? end;

  const EventTimeDetailObj({
    this.start,
    this.end,
  });
}

class MapEventObj {
  final double lat;
  final double lon;
  final String name;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int eventId;

  const MapEventObj(
      {required this.lat,
      required this.lon,
      required this.name,
      required this.dateStart,
      required this.dateEnd,
      required this.eventId});

  factory MapEventObj.fromMap(Map<String, dynamic> map) {
    return MapEventObj(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      name: map['name'] as String,
      dateStart: map['dateStart'] as DateTime,
      dateEnd: map['dateEnd'] as DateTime,
      eventId: map['eventId'] as int,
    );
  }
}
