
import 'package:geolocator/geolocator.dart';

class LocationMixin {

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = await Geolocator.getLastKnownPosition();
    }
    if (position == null) {
      return Future.error("Could not get location");
    }
    return position;
  }

}