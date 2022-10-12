import 'package:appalimentacion/domain/models/models.dart';

abstract class ProjectsCacheApi {
  const ProjectsCacheApi();

  Stream<Map<String, ProjectCache>> getProjectsCache();

  ProjectCache getCache();

  DatosAlimentacion getDetail(int projectCode);

  Future<void> saveProjectCache(int projectCode, ProjectCache projectCache);

  Stream<List<Project>> getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails();

  Future<void> saveProjects(List<Project> projects);

  Future<void> saveProjectsDetail(Map<String, DatosAlimentacion> details);

  Future<void> saveDetail(DatosAlimentacion detail);
}

class CacheNotFoundException implements Exception {}
