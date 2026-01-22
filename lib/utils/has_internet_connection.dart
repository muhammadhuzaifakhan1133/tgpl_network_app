import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivity {
  static Future<bool> hasInternet() async {
    return await InternetConnection().hasInternetAccess;
  }
}