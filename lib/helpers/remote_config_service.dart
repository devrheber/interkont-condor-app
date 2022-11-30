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
      'sentry_dsn':
          'https://dcdb599c3313428eaea9318ae8407d2a@o1172295.ingest.sentry.io/4504091069972480',
      'feature_estado_obra_aom': 1,
      'feature_estado_obra_alimentacion': 9,
      'reporte_aom_step3_max_mb_size_video': 30,
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
