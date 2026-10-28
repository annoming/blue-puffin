import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  const PermissionService();

  Future<bool> requestLocation() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> requestLocationAlways() async {
    final status = await Permission.locationAlways.request();
    return status.isGranted;
  }

  Future<bool> hasLocation() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  Future<bool> requestAllRunPermissions() async {
    // Check if location service is enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Try to request location service; in practice guide user to settings
      await Geolocator.openLocationSettings();
      return false;
    }

    // Request when-in-use first
    var status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    if (!status.isGranted) {
      return false;
    }

    // Try to request background/locationAlways for run tracking
    status = await Permission.locationAlways.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    // Return true if at least foreground location granted; background may be limited
    return await Permission.location.isGranted;
  }

  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
