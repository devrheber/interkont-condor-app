import 'dart:async';
import 'dart:developer';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
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
  Map<String, ProjectCache> cache = {};

  Stream<List<Project>> get projectsStream =>
      _projectsCacheRepository.getProjects();

  Stream<Map<String, ProjectCache>> get cacheStream =>
      _projectsCacheRepository.getProjectsCache();

  Map<String, dynamic> error = {'error': false, 'message': 'Algo salió mal'};

  StreamController<double> _executedPercentageStreamController =
      StreamController.broadcast();

  Stream<double> get executedPercentageStream =>
      _executedPercentageStreamController.stream;

  StreamSubscription<Map<String, DatosAlimentacion>> detailsSubscription;
  StreamSubscription<Map<String, ProjectCache>> cacheSubscription;

  @override
  void dispose() {
    _executedPercentageStreamController.close();
    detailsSubscription.cancel();
    cacheSubscription.cancel();
    super.dispose();
  }

  _init() {
    detailsSubscription =
        _projectsCacheRepository.getDetails().listen((details) {
      this.details = details;
    });

    cacheSubscription =
        _projectsCacheRepository.getProjectsCache().listen((cache) {
      this.cache = cache;
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
    await _projectsCacheRepository.saveProjectDetails(details);
    inspect(details);
  }

  Future<void> saveCache(int codigoProyecto, ProjectCache data) async {
    cache[codigoProyecto.toString()] = data;
    await _projectsCacheRepository.saveProjectCache(
        codigoProyecto.toString(), cache[codigoProyecto.toString()]);
    inspect(details);
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

      return detail;
    } catch (_) {
      throw '';
    }
  }

  updateExcutedPercentage() {
    // TODO
    final double newValue = 45.70;
    _executedPercentageStreamController.add(newValue);
  }
}
