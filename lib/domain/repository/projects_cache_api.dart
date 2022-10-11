import 'package:appalimentacion/domain/models/models.dart';

abstract class ProjectsCacheApi {
  const ProjectsCacheApi();

  Stream<Map<String, ProjectCache>> getProjectsCache();

  Future<void> saveProjectCache(String projectCode, ProjectCache projectCache);

  Stream<List<Project>> getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails();

  Future<void> saveProjects(List<Project> projects);

  Future<void> saveProjectsDetail(Map<String, DatosAlimentacion> details);
}

class CacheNotFoundException implements Exception {}
