
class WeatherRequest {

  final String startDate;
  final String endDate;
  final double lat;
  final double lon;

  const WeatherRequest({
    required this.startDate,
    required this.endDate,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateStart': this.startDate,
      'dateEnd': this.endDate,
      'lat': this.lat,
      'lon': this.lon,
    };
  }

  factory WeatherRequest.fromMap(Map<String, dynamic> map) {
    return WeatherRequest(
      startDate: map['dateStart'] as String,
      endDate: map['dateEnd'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

}