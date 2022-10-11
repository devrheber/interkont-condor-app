import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_cache_api.dart';
import 'package:flutter/foundation.dart';

class ProjectsCacheRepository {
  const ProjectsCacheRepository({
    @required ProjectsCacheApi projectsCacheApi,
  }) : _projectsCacheApi = projectsCacheApi;

  final ProjectsCacheApi _projectsCacheApi;

  Stream<Map<String, ProjectCache>> getProjectsCache() =>
      _projectsCacheApi.getProjectsCache();

  Stream<List<Project>> getProjects() => _projectsCacheApi.getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails() =>
      _projectsCacheApi.getDetails();

  Future<void> saveProjectCache(
          String projectCode, ProjectCache projectCache) =>
      _projectsCacheApi.saveProjectCache(projectCode, projectCache);

  Future<void> saveProjects(List<Project> projects) =>
      _projectsCacheApi.saveProjects(projects);

  Future<void> saveProjectDetails(Map<String, DatosAlimentacion> details) =>
      _projectsCacheApi.saveProjectsDetail(details);
}
