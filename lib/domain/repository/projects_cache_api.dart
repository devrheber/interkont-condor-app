import 'package:appalimentacion/domain/models/models.dart';

abstract class ProjectsCacheApi {
  const ProjectsCacheApi();

  Stream<Map<String, ProjectCache>> getProjectsCache();

  Future<void> saveProjectCache(String projectCode, ProjectCache projectCache);
}

class CacheNotFoundException implements Exception {}
