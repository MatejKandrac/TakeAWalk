
class CreateEventData {
  int? ownerId;
  final String? description;
  final DateTime start;
  final DateTime end;
  final String name;
  final List<int> users;
  final List<LocationData> locations;

  CreateEventData({
    this.description,
    this.ownerId,
    required this.start,
    required this.end,
    required this.name,
    required this.users,
    required this.locations
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': this.ownerId,
      'description': this.description,
      'start': start.toIso8601String(),
      'endDate': end.toIso8601String(),
      'name': this.name,
      'users': this.users,
      'locations': locations.map((e) => e.toMap()).toList(),
    };
  }

  factory CreateEventData.fromMap(Map<String, dynamic> map) {
    return CreateEventData(
      ownerId: map['ownerId'] as int,
      description: map['description'] as String,
      start: map['start'] as DateTime,
      end: map['end'] as DateTime,
      name: map['name'] as String,
      users: map['users'] as List<int>,
      locations: map['locations'] as List<LocationData>,
    );
  }

}


class LocationData {
  final double lat;
  final double lon;
  final String name;
  final int order;

  LocationData({
    required this.lat,
    required this.lon,
    required this.name,
    required this.order
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lon': this.lon,
      'name': this.name,
      'order': this.order,
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      name: map['name'] as String,
      order: map['order'] as int,
    );
  }

}