import 'dart:async';

import 'package:appalimentacion/blocs/network/network_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkHelper {
  const NetworkHelper._();

  static final NetworkHelper _instance = NetworkHelper._();

  factory NetworkHelper() => _instance;

  static StreamSubscription? _subcription;
  static Future<void> observeNetwork() async {
    await _subcription?.cancel();
    _subcription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }

  static dispose() {
    _subcription?.cancel();
    debugPrint('disposing network helper');
  }
}
