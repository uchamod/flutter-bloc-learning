import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider {
  //get the current city
  Future<String> getCurrentCity() async {
    try {
      bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnable) {
        return Future.error('Location services are disabled.');
      }
      //request to permission to accsess the location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permission is denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permission is denied forever.');
      }

      //if permissions not denied get the current location
      Position possition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      //placemark for given coordinates
      List<Placemark> placeMark = await placemarkFromCoordinates(
        possition.latitude,
        possition.longitude,
      );
      if (placeMark.isNotEmpty) {
        return placeMark[0].locality ??
            placeMark[0].subAdministrativeArea ??
            "London";
      } else {
        return "London"; // Default fallback
      }
    } catch (err) {
      throw Exception("Something went wrong " + err.toString());
    }
  }
}
