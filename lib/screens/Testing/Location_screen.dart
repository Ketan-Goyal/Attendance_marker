import 'package:attendance_marker/services/location_services.dart';
import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_web/geolocator_web.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationServices locServ = LocationServices();
  void getLocation() async {
    await locServ.getCurrentLocation();
    print("latitude :");
    print(locServ.latitude);
    print("longitude :");
    print(locServ.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: TextButton(
          onPressed: () {
            getLocation();
          },
          child: Text("GET LOCATION"),
        )),
      ),
    );
  }
}
