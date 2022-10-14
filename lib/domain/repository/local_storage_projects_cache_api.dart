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

  int currentProjectCode;

  final _projectsCacheStreamController =
      BehaviorSubject<Map<String, ProjectCache>>.seeded(const {});

  final _executedValuePercentageStreamController =
      BehaviorSubject<double>.seeded(0.0);

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
  Stream<double> getExecutedValuePercentage() =>
      _executedValuePercentageStreamController.asBroadcastStream();

  @override
  Future<void> saveProjectCache(
      int projectCode, ProjectCache projectCache) async {
    final map = {..._projectsCacheStreamController.value};

    map[projectCode.toString()] = projectCache;

    _projectsCacheStreamController.add(map);
    return _setValue(kCacheMapKey, projectsCacheToJson(map));
  }

  @override
  Future<void> saveProjects(List<Project> projects) async {
    final list = [...projects];
    _projectsStreamController.add(list);
    return _setValue(kProjectsKey, vistaListaResponseToJson(list));
  }

  @override
  Future<void> saveProjectsDetail(int projectCode, DatosAlimentacion details) {
    final map = {..._detailStreamController.value};

    map[projectCode.toString()] = details;
    currentProjectCode = projectCode;

    _detailStreamController.add(map);
    return _setValue(kDetailsKey, projetsDetailToJson(map));
  }

  @override
  Project getProject() {
    final list = [..._projectsStreamController.value];
    return list
        .firstWhere((project) => project.codigoproyecto == currentProjectCode);
  }

  @override
  DatosAlimentacion getDetail(int projectCode) {
    final map = {..._detailStreamController.value};
    if (map.containsKey(projectCode.toString())) {
      return map[projectCode.toString()];
    } else {
      return null;
    }
  }

  @override
  ProjectCache getCache() {
    final projectsCache = {..._projectsCacheStreamController.value};
    if (projectsCache.containsKey(currentProjectCode.toString())) {
      return projectsCache[currentProjectCode.toString()];
    }
    return null;
  }

  @override
  Future<void> saveDetail(DatosAlimentacion detail) {
    final map = {..._detailStreamController.value};
    map[currentProjectCode.toString()] = detail;
    return _setValue(kDetailsKey, projetsDetailToJson(map));
  }

  @override
  Future<void> saveCache(ProjectCache cache) {
    final map = {..._projectsCacheStreamController.value};
    map[currentProjectCode.toString()] = cache;
    _executedValuePercentageStreamController
        .add(cache.porcentajeValorEjecutado);
    return _setValue(kCacheMapKey, projectsCacheToJson(map));
  }

  @override
  void setCurrentProjectCode(int projectCode) {
    currentProjectCode = projectCode;
  }
}
