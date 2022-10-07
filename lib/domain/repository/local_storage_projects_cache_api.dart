import 'dart:convert';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_cache_api.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageProjectsCacheApi extends ProjectsCacheApi {
  LocalStorageProjectsCacheApi({
    @required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _projectsCacheStreamController =
      BehaviorSubject<Map<String, ProjectCache>>.seeded(const {});

  @visibleForTesting
  static const kCacheMapKey = '__todos_collection_key__';

  String _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final projectsCacheJson = _getValue(kCacheMapKey);
    if (projectsCacheJson != null) {
      final projectsCache = projectsCacheFromJson(projectsCacheJson);
      _projectsCacheStreamController.add(projectsCache);
    } else {
      _projectsCacheStreamController.add(const {});
    }
  }

  @override
  Stream<Map<String, ProjectCache>> getProjectsCache() =>
      _projectsCacheStreamController.asBroadcastStream();

  @override
  Future<void> saveProjectCache(
      String projectCode, ProjectCache projectCache) async {
    final projectsCache = {..._projectsCacheStreamController.value};

    projectsCache[projectCode] = projectCache;

    _projectsCacheStreamController.add(projectsCache);
    return _setValue(kCacheMapKey, projectsCacheToJson(projectsCache));
  }
}
