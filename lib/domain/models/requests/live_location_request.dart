
class LiveLocationRequest {

  final double lat;
  final double lon;

  const LiveLocationRequest({
    required this.lat,
    required this.lon
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lon': this.lon,
    };
  }

  factory LiveLocationRequest.fromMap(Map<String, dynamic> map) {
    return LiveLocationRequest(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }
}