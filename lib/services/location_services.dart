import 'package:geolocator/geolocator.dart';

class LocationServices {
  double longitude = 0;
  double latitude = 0;

  late LocationPermission permission;

  Future<void> getCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      longitude = 181;
      latitude = 181;
    }
  }
}
