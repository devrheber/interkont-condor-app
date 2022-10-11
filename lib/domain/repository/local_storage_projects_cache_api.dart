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

  final _projectsStreamController =
      BehaviorSubject<List<Project>>.seeded(const []);

  final _detailStreamController =
      BehaviorSubject<Map<String, DatosAlimentacion>>.seeded({});

  @visibleForTesting
  static const kCacheMapKey = '__cache_collection_key__';
  static const kProjectsKey = '__projects_collection_key__';
  static const kDetailsKey = '__details_collection_key__';

  String _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final projectsCacheJson = _getValue(kCacheMapKey);
    final projectsJson = _getValue(kProjectsKey);
    final detailsJson = _getValue(kDetailsKey);
    if (projectsCacheJson != null) {
      final projectsCache = projectsCacheFromJson(projectsCacheJson);
      _projectsCacheStreamController.add(projectsCache);
    } else {
      _projectsCacheStreamController.add(const {});
    }

    if (projectsJson != null) {
      final projects = vistaListaResponseFromJson(projectsJson);
      _projectsStreamController.add(projects);
    } else {
      _projectsStreamController.add(const []);
    }

    if (detailsJson != null) {
      final details = projectsDetailFromJson(detailsJson);
      _detailStreamController.add(details);
    }
  }

  @override
  Stream<Map<String, ProjectCache>> getProjectsCache() =>
      _projectsCacheStreamController.asBroadcastStream();

  @override
  Stream<Map<String, DatosAlimentacion>> getDetails() =>
      _detailStreamController.asBroadcastStream();

  @override
  Stream<List<Project>> getProjects() =>
      _projectsStreamController.asBroadcastStream();

  @override
  Future<void> saveProjectCache(
      String projectCode, ProjectCache projectCache) async {
    final projectsCache = {..._projectsCacheStreamController.value};

    projectsCache[projectCode] = projectCache;

    _projectsCacheStreamController.add(projectsCache);
    return _setValue(kCacheMapKey, projectsCacheToJson(projectsCache));
  }

  @override
  Future<void> saveProjects(List<Project> projects) async {
    final list = [...projects];
    _projectsStreamController.add(list);
    return _setValue(kProjectsKey, vistaListaResponseToJson(list));
  }

  @override
  Future<void> saveProjectsDetail(Map<String, DatosAlimentacion> details) {
    final map = {...details};
    _detailStreamController.add(map);
    return _setValue(kDetailsKey, projetsDetailToJson(map));
  }
}
