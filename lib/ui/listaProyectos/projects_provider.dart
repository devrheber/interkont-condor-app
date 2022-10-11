import 'dart:async';
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
  }

  final ProjectsRepository projectRepository;

  final ProjectsCacheRepository _projectsCacheRepository;

  int indexProjectSelected = 0;

  Map<String, DatosAlimentacion> details = {};

  Stream<List<Project>> get projectsStream => _projectsCacheRepository.getProjects();
  Stream<Map<String, ProjectCache>> get cacheStream => _projectsCacheRepository.getProjectsCache();

  Map<String, dynamic> error = {'error': false, 'message': 'Algo salió mal'};

  

  StreamController<double> _executedPercentageStreamController =
      StreamController.broadcast();

  Stream<double> get executedPercentageStream =>
      _executedPercentageStreamController.stream;

  @override
  void dispose() {
    _executedPercentageStreamController.close();
    super.dispose();
  }

  Future<void> getRemoteProjects() async {
    final projects = await projectRepository.getProjects();

    _saveProjectsInLocalStorage(projects);
    notifyListeners();
  }

  Future<void> getDataFromLocalStorage() async {}

  Future<void> _saveProjectsInLocalStorage(List<Project> projects) async {
    await _projectsCacheRepository.saveProjects(projects);
  }

  Future<void> _saveDetail(int codigoProyecto, DatosAlimentacion data) async {
    final key = codigoProyecto.toString();
    Map<String, DatosAlimentacion> map = {};

    map = {key: data};

    await _projectsCacheRepository.saveProjectDetails(map);
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

  updateExcutedPercentage() {
    // TODO
    final double newValue = 45.70;
    _executedPercentageStreamController.add(newValue);
  }
}
