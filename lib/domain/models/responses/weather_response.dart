
class WeatherResponse {

  final String date;
  final Map<String, dynamic> data;

  const WeatherResponse({
    required this.date,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'data': this.data,
    };
  }

  factory WeatherResponse.fromMap(Map<String, dynamic> map) {
    return WeatherResponse(
      date: map['date'] as String,
      data: map['data'] as Map<String, dynamic>,
    );
  }

}