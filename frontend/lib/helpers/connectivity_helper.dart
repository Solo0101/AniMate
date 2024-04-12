import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<bool> isDeviceConnectedToTheInternet() async {
    var connectivityStatus = await Connectivity().checkConnectivity();
    return connectivityStatus == ConnectivityResult.wifi ||
        connectivityStatus == ConnectivityResult.mobile;
  }
}
