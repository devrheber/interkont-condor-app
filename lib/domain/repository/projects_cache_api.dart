import 'package:appalimentacion/domain/models/models.dart';

abstract class ProjectsCacheApi {
  const ProjectsCacheApi();

  Stream<Map<String, ProjectCache>> getProjectsCache();

  ProjectCache getCache();

  Project getProject();

  DatosAlimentacion getDetail(int projectCode);

  Future<void> saveProjectCache(int projectCode, ProjectCache projectCache);

  Stream<List<Project>> getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails();

  Stream<double> getExecutedValuePercentage();

  Future<void> saveProjects(List<Project> projects);

  Future<void> saveProjectsDetail(int projectCode, DatosAlimentacion details);

  Future<void> saveDetail(DatosAlimentacion detail);

  Future<void> saveCache(ProjectCache cache);

  void setCurrentProjectCode(int projectCode);
}

class CacheNotFoundException implements Exception {}
