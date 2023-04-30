
class Location {
  final double lat;
  final double lon;
  final String name;

  const Location({required this.lat, required this.lon, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lon': this.lon,
      'name': this.name,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      name: (map['name'] as String?) ?? "",
    );
  }
}