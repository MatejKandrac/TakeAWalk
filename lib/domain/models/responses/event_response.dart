import 'location.dart';
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

enum Status {
  ACCEPTED,
  DECLINED,
  PENDING;
}

class EventObject {
  final String name;
  final String owner;
  final DateTime start;
  final DateTime end;
  final List<Location> locations;
  final int? peopleGoing;
  final int? places;
  final int eventId;

  const EventObject({
    required this.name,
    required this.owner,
    required this.start,
    required this.end,
    required this.locations,
    this.peopleGoing,
    this.places,
    required this.eventId,
  });

  factory EventObject.fromMap(Map<String, dynamic> map) {
    return EventObject(
      name: map['name'] as String,
      owner: map['owner'] as String,
      start: DateTime.parse(map['start'] as String).toLocal(),
      end: DateTime.parse(map['end'] as String).toLocal(),
      locations: (map['locations'] as List<dynamic>).map((e) => Location.fromMap(e)).toList(),
      peopleGoing: map['peopleGoing'] as int?,
      places: map['places'] as int?,
      eventId: map['eventId'] as int,
    );
  }

}

class EventDataResponse {
  final int ownerId;
  final String eventHost;
  final String eventName;
  final List<Location> eventLocations;
  final EventTimeDetailObj eventTime;
  final String? eventStatus;
  final int currentIndex;
  final double? ownerLat;
  final double? ownerLon;

  const EventDataResponse({
    required this.ownerId,
    required this.eventHost,
    required this.eventName,
    required this.eventLocations,
    required this.eventTime,
    this.ownerLat,
    this.ownerLon,
    this.eventStatus,
    required this.currentIndex,
  });

  factory EventDataResponse.fromMap(Map<String, dynamic> map) {
    return EventDataResponse(
      ownerId: map['ownerId'] as int,
      eventHost: map['eventHost'] as String,
      eventName: map['eventName'] as String,
      eventLocations: (map['eventLocations'] as List<dynamic>).map((e) => Location.fromMap(e)).toList(),
      eventTime: EventTimeDetailObj.fromMap(map['eventTime']),
      eventStatus: map['eventStatus'] as String?,
      currentIndex: map['currentIndex'] as int,
      ownerLat: map['ownerLat'] as double?,
      ownerLon: map['ownerLon'] as double?
    );
  }

}

class EventTimeDetailObj {
  final DateTime? start;
  final DateTime? end;

  const EventTimeDetailObj({
    this.start,
    this.end,
  });

  Map<String, dynamic> toMap() {
    return {
      'start': this.start,
      'end': this.end,
    };
  }

  factory EventTimeDetailObj.fromMap(Map<String, dynamic> map) {
    return EventTimeDetailObj(
      start: DateTime.parse(map['start']).toLocal(),
      end: DateTime.parse(map['end']).toLocal(),
    );
  }
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
      // dateStart: map['dateStart'] as DateTime,
      dateStart: DateTime.parse(map['dateStart'] as String).toLocal(),
      // dateEnd: map['dateEnd'] as DateTime,
      dateEnd: DateTime.parse(map['dateEnd'] as String).toLocal(),
      eventId: map['eventId'] as int,
    );
  }
}
