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

  Future<void> saveProjectCache(
          String projectCode, ProjectCache projectCache) =>
      _projectsCacheApi.saveProjectCache(projectCode, projectCache);
}
