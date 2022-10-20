import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_cache_api.dart';

class ProjectsCacheRepository {
  const ProjectsCacheRepository({
    required ProjectsCacheApi projectsCacheApi,
  }) : _projectsCacheApi = projectsCacheApi;

  final ProjectsCacheApi _projectsCacheApi;

  Stream<Map<String, ProjectCache>> getProjectsCache() =>
      _projectsCacheApi.getProjectsCache();

  ProjectCache? getCache() => _projectsCacheApi.getCache();

  ProjectCache? getCacheByProjectCode(int projectCode) =>
      _projectsCacheApi.getCacheByProjectCode(projectCode);

  Project getProject() => _projectsCacheApi.getProject();

  List<TipoDoc>? getDocumentTypes() => _projectsCacheApi.getDocumentTypes();

  DatosAlimentacion? getDetail(int projectCode) =>
      _projectsCacheApi.getDetail(projectCode);

  Stream<List<Project>> getProjects() => _projectsCacheApi.getProjects();

  Stream<Map<String, DatosAlimentacion>> getDetails() =>
      _projectsCacheApi.getDetails();

  Stream<double> getExecutedValuePercentage() =>
      _projectsCacheApi.getExecutedValuePercentage();

  Future<void> saveProjectCache(int projectCode, ProjectCache projectCache) =>
      _projectsCacheApi.saveProjectCache(projectCode, projectCache);

  Future<void> saveProjects(List<Project> projects) =>
      _projectsCacheApi.saveProjects(projects);

  Future<void> saveProjectDetails(int projectCode, DatosAlimentacion details) =>
      _projectsCacheApi.saveProjectsDetail(projectCode, details);

  Future<void> saveDetail(DatosAlimentacion detail) =>
      _projectsCacheApi.saveDetail(detail);

  Future<void> saveCache(ProjectCache cache) =>
      _projectsCacheApi.saveCache(cache);

  Future<void> saveDocumentTypes(List<TipoDoc> types) =>
      _projectsCacheApi.saveDocumentTypes(types);

  void setCurrentProjectCode(int projectCode) =>
      _projectsCacheApi.setCurrentProjectCode(projectCode);

  void clearData() => _projectsCacheApi.clearData();

  void removeCacheByCode(int projectCode) =>
      _projectsCacheApi.removeCacheByCode(projectCode);
}
