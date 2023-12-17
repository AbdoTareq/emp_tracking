import 'package:connectivity_plus/connectivity_plus.dart';

import '../export.dart';

class ConnectivityController extends GetxController {
  bool isOnline = true;
  bool isDisconnected = false;

  ConnectivityController() {
    Connectivity _connectivity = Connectivity();
    _connectivity.checkConnectivity().then((value) {
      isOnline = value != ConnectivityResult.none;
      update();
      logger.i(isOnline);
    });
    _connectivity.onConnectivityChanged.listen((result) {
      logger.i('xxxs ${result.name}');
      logger.i(isOnline);
      if (result.name == 'none') {
        isOnline = false;
        isDisconnected = true;
      } else {
        isOnline = true;
        if (isDisconnected) {}
      }
      update();
    });
  }
}
