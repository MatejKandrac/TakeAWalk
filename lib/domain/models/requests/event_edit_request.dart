
class EventEditRequest {
  
  final DateTime? start;
  final DateTime? end;
  final List<LocationNew>? newLocations;
  final List<int>? newPeople;
  final List<int>? deletedPictures;

  const EventEditRequest({
    this.start,
    this.end,
    this.newLocations,
    this.newPeople,
    this.deletedPictures,
  });

  Map<String, dynamic> toMap() {
    return {
      if (this.start != null) 'start': this.start!.toUtc().toIso8601String(),
      if (this.end != null) 'end': this.end?.toUtc().toIso8601String(),
      if (this.newLocations != null && newLocations!.isNotEmpty) 'newLocations': this.newLocations!.map((e) => e.toMap()).toList(),
      if (newPeople != null && newPeople!.isNotEmpty) 'newPeople': this.newPeople,
      if (deletedPictures != null && deletedPictures!.isNotEmpty) 'deletedPictures': this.deletedPictures,
    };
  }
}


class LocationNew {
  final String name;
  final double lat;
  final double lon;
  final int order;

  const LocationNew({
    required this.name,
    required this.lat,
    required this.lon,
    required this.order
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'lat': this.lat,
      'lon': this.lon,
      'order': this.order
    };
  }

}