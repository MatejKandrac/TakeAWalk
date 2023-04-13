
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

  const EventResponse({
    required this.id,
    required this.name,
    required this.owner,
    required this.dateStart,
    required this.dateEnd,
    required this.status,
    required this.locations,
    required this.profiles
  });

}


class Location {

  final double lat;
  final double lon;
  final String name;

  const Location({
    required this.lat,
    required this.lon,
    required this.name
  });
}

enum Status {
  ACCEPTED, DECLINED, PENDING;
}