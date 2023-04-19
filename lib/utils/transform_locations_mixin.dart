

import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';

class TransformLocationsMixin {

  LatLng toLatLon(Location location) {
    return LatLng(location.lat, location.lon);
  }

  List<LatLng> toListLatLon(List<Location> locations) {
    return locations.map((e) => LatLng(e.lat, e.lon)).toList();
  }

}