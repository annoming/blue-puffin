import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class PermissionService {
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<bool> requestBackgroundLocationPermission() async {
    if (await requestLocationPermission()) {
      // For iOS/Android background location
      var status = await Permission.locationAlways.request();
      return status.isGranted;
    }
    return false;
  }

  Future<bool> requestAllRunPermissions() async {
    final locationGranted = await requestLocationPermission();
    if (!locationGranted) return false;
    await requestBackgroundLocationPermission();
    return locationGranted;
  }
}
