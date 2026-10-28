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
}
