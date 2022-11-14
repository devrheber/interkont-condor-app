import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  factory RemoteConfigService() => _instancia;
  RemoteConfigService._internal();
  static final RemoteConfigService _instancia = RemoteConfigService._internal();

  final remoteConfig = FirebaseRemoteConfig.instance;

  init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(
        hours: kDebugMode ? 0 : 1,
        minutes: kDebugMode ? 5 : 0,
      ),
    ));

    await remoteConfig.setDefaults(const {
      'feature_estado_obra_aom': 1,
      'feature_estado_obra_alimentacion': 9,
    });


    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
  }

  Future<void> updateConfigs() async {
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
  }

  int getInt(String key) => remoteConfig.getInt(key);

  String getString(String key) => remoteConfig.getString(key);
}
