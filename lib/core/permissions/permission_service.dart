import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class PermissionService {
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
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
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }

  Future<bool> requestBackgroundLocationPermission() async {
    if (!await requestLocationPermission()) {
      return false;
    }

    if (Platform.isAndroid) {
      var status = await ph.Permission.locationAlways.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        if (status.isPermanentlyDenied) {
          await ph.openAppSettings();
        }
        return status.isGranted;
      }
      return status.isGranted;
    } else if (Platform.isIOS) {
      var status = await ph.Permission.locationAlways.request();
      if (status.isPermanentlyDenied) {
        await ph.openAppSettings();
      }
      return status.isGranted;
    }
    return true;
  }

  Future<bool> requestAllRunPermissions() async {
    final locationGranted = await requestLocationPermission();
    if (!locationGranted) return false;
    final backgroundGranted = await requestBackgroundLocationPermission();
    return locationGranted;
  }
}
