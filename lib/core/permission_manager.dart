import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<String> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can now access the location.
      return "";
    } else if (status.isDenied) {
      // Permission denied.
      return "Location permission denied";
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings.
      openAppSettings();
      return "Location permission permanently denied";
    }
    return 'no permission';
  }
}
