import 'dart:async';
import 'dart:developer';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:flutter/material.dart';

class ProjectsProvider extends ChangeNotifier {
  ProjectsProvider({
    @required this.projectRepository,
    @required this.prefs,
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    getProjects();
    _getCacheFromLocalStorage();
    _init();
  }

  final ProjectsRepository projectRepository;
  final UserPreferences prefs;

  final ProjectsCacheRepository _projectsCacheRepository;

  List<Project> localProjects = [];

  int indexProjectSelected = 0;

  Map<String, ProjectCache> cache = {};
  Map<String, DatosAlimentacion> details = {};

  Map<String, dynamic> error = {'error': false, 'message': 'Algo salió mal'};

  StreamSubscription cacheStream;

  _init() {
    cacheStream = _projectsCacheRepository.getProjectsCache().listen((map) {
      this.cache = map;
    });
  }

  void dispose() {
    cacheStream.cancel();
  }

  Future<void> getProjectsFromLocalStorage() async {
    // TODO Verificar última consulta para evitar consultar data actualizada
    final localProjectsString = prefs.projects;
    if (localProjectsString == '') return;
    localProjects = vistaListaResponseFromJson(localProjectsString);
    notifyListeners();
  }

  Future<void> getProjects() async {
    try {
      await getRemoteProjects();
    } catch (_) {
      await getProjectsFromLocalStorage();
    }
  }

  Future<void> getRemoteProjects() async {
    final projects = await projectRepository.getProjects();
    localProjects = projects;
    _saveProjectsInLocalStorage(localProjects);
    notifyListeners();
  }

  Future<void> getDataFromLocalStorage() async {
    final localProjectsString = prefs.projects;

    if (localProjectsString != '') {
      localProjects = vistaListaResponseFromJson(localProjectsString);
    }
  }

  void _saveProjectsInLocalStorage(List<Project> projects) {
    // TODO Establecer última sincronización
    prefs.projects = vistaListaResponseToJson(projects);
    for (final project in projects) {
      if (!cache.containsKey(project.codigoproyecto.toString())) {
        cache[project.codigoproyecto.toString()] = ProjectCache();
      }
    }
  }

  void _saveDetail(int codigoProyecto, DatosAlimentacion data) {
    final key = codigoProyecto.toString();
    Map<String, DatosAlimentacion> map = {};

    final details = prefs.projectsDetail;

    if (details == '') {
      map = {key: data};
    } else {
      map = projectsDetailFromJson(details);
      map[key] = data;
    }

    this.details = map;
    prefs.projectsDetail = projetsDetailToJson(map);

    inspect(projectsDetailFromJson(prefs.projectsDetail));
  }


  Future<DatosAlimentacion> getProjectDetail(int codigoProyecto,
      {@required int index}) async {
    this.indexProjectSelected = index;
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

      _saveDetail(codigoProyecto, detail);

      return detail;
    } catch (_) {
      throw '';
    }
  }

  void _getCacheFromLocalStorage() {
    _projectsCacheRepository.getProjectsCache();
    final cache = prefs.projectsCache;
    if (cache == '') return null;

    final map = projectsCacheFromJson(cache);

    this.cache = map;
  }
}
