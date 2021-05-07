import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:restaurants/utils/Common.dart';
import 'package:restaurants/utils/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectivityStatus {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  SharedPreferences sharedPreferences;

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      connectionEvent(result);
    });
  }

  void connectionEvent(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile) {
      print(Strings.CON_INTERNET);
      Common.connection = Strings.CON_INTERNET;
    } else if (result == ConnectivityResult.wifi) {
      print(Strings.CON_WIFI);
      Common.connection = Strings.CON_WIFI;
    } else {
      Common.connection = Strings.CON_NON;
      print(Strings.CON_NON);
    }
  }
}
