import 'dart:async';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ProjectsProvider extends ChangeNotifier {
  ProjectsProvider({
    @required this.projectRepository,
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    getRemoteProjects();
    _init();
  }

  final ProjectsRepository projectRepository;
  final ProjectsCacheRepository _projectsCacheRepository;

  Map<String, DatosAlimentacion> details = {};

  Stream<List<Project>> get projectsStream =>
      _projectsCacheRepository.getProjects();

  Stream<Map<String, ProjectCache>> get cacheStream =>
      _projectsCacheRepository.getProjectsCache();

  Stream<double> get getExecutedValuePercentage =>
      _projectsCacheRepository.getExecutedValuePercentage();

  _init() {
    _projectsCacheRepository.getDetails().listen((detailsCache) {
      this.details = detailsCache;
    });
  }

  Future<void> getRemoteProjects() async {
    final projects = await projectRepository.getProjects();

    _saveProjectsInLocalStorage(projects);
    notifyListeners();
  }

  Future<void> _saveProjectsInLocalStorage(List<Project> projects) async {
    await _projectsCacheRepository.saveProjects(projects);
  }

  Future<void> saveDetail(int codigoProyecto, DatosAlimentacion data) async {
    details[codigoProyecto.toString()] = data;
    await _projectsCacheRepository.saveProjectDetails(codigoProyecto, data);
  }

  Future<void> _saveSyncDate(int projectCode, DateTime syncDate) async {
    ProjectCache cache =
        _projectsCacheRepository.getCacheByProjectCode(projectCode);

    if (cache == null) {
      cache = ProjectCache(lastSyncDate: syncDate);
    } else {
      cache = cache.copyWith(lastSyncDate: syncDate);
    }

    _projectsCacheRepository.saveProjectCache(projectCode, cache);
  }

  Future<DatosAlimentacion> getProjectDetail(int codigoProyecto,
      {@required int index}) async {
    try {
      final localDetail = details['$codigoProyecto'];

      if (localDetail != null) {
        return localDetail;
      } else {
        final detail = await _getRemoteProjectDetail(codigoProyecto);
        return detail;
      }
    } catch (_) {
      throw '';
    }
  }

  Future<DatosAlimentacion> _getRemoteProjectDetail(int codigoProyecto) async {
    try {
      final detail = await projectRepository.getDatosAlimentacion(
          codigoProyecto: '$codigoProyecto');

      saveDetail(codigoProyecto, detail);

      final syncDate = DateTime.now();
      _saveSyncDate(codigoProyecto, syncDate);

      return detail;
    } catch (_) {
      throw '';
    }
  }

  void setCurrentProjectCode(int projectCode) {
    _projectsCacheRepository.setCurrentProjectCode(projectCode);
  }
}
