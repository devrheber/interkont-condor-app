import 'package:appalimentacion/domain/models/models.dart';

abstract class ProjectsCacheApi {
  const ProjectsCacheApi();

  Stream<Map<String, ProjectCache>> getProjectsCache();

  ProjectCache? getCache();

  ProjectCache? getCacheByProjectCode(int projectCode);

  Project getProject();

  DatosAlimentacion? getDetail(int projectCode);

  Future<void> saveProjectCache(int projectCode, ProjectCache projectCache);

  Stream<List<Project>> getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails();

  Stream<double> getExecutedValuePercentage();

  Future<void> saveProjects(List<Project> projects);

  Future<void> saveProjectsDetail(int projectCode, DatosAlimentacion details);

  Future<void> saveDetail(DatosAlimentacion detail);

  Future<void> saveCache(ProjectCache cache);

  Future<void> saveDocumentTypes(List<TipoDoc> types);

  List<TipoDoc>? getDocumentTypes();

  void setCurrentProjectCode(int projectCode);

  void clearData();
}

class CacheNotFoundException implements Exception {}
