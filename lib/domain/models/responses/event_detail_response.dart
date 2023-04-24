
import 'location.dart';

class EventDetailResponse {

  final int ownerId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String eventName;
  final String ownerName;
  final List<String>? pictures;
  final List<EventInvite> people;
  final List<Location> locations;

  const EventDetailResponse({
    required this.ownerId,
    required this.dateStart,
    required this.dateEnd,
    required this.eventName,
    required this.ownerName,
    this.pictures,
    required this.people,
    required this.locations,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateStart': this.dateStart,
      'dateEnd': this.dateEnd,
      'eventName': this.eventName,
      'ownerName': this.ownerName,
      'pictures': this.pictures,
      'people': this.people,
      'locations': this.locations,
    };
  }

  factory EventDetailResponse.fromMap(Map<String, dynamic> map) {
    return EventDetailResponse(
      ownerId: map['ownerId'] as int,
      dateStart: map['dateStart'] as DateTime,
      dateEnd: map['dateEnd'] as DateTime,
      eventName: map['eventName'] as String,
      ownerName: map['ownerName'] as String,
      pictures: map['pictures'] as List<String>,
      people: map['people'] as List<EventInvite>,
      locations: map['locations'] as List<Location>,
    );
  }

}


class EventInvite {

  final String name;
  final String? profileImage;
  final String inviteStatus;

  const EventInvite({
    required this.name,
    required this.profileImage,
    required this.inviteStatus
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'profileImage': this.profileImage,
      'inviteStatus': this.inviteStatus,
    };
  }

  factory EventInvite.fromMap(Map<String, dynamic> map) {
    return EventInvite(
      name: map['name'] as String,
      profileImage: map['profileImage'] as String?,
      inviteStatus: map['inviteStatus'] as String,
    );
  }
}