
import 'package:geolocator/geolocator.dart';

class LocationMixin {

  Future<bool> handlePermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      print("Location services are disabled");
      return false;
    }

    return true;
  }

  Future<Position?> getPosition() async {

    if (!(await handlePermission())) {
      return Future.error("Did not get permission");
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

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 100
    ));
  }

}