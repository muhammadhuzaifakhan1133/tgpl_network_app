import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivity {
  static Future<bool> hasInternet() async {
    return await InternetConnection().hasInternetAccess;
  }

  static StreamSubscription<InternetStatus> listen(void Function(InternetStatus)? onData) {
    return InternetConnection().onStatusChange.listen(onData);
  }
}