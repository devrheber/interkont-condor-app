import 'dart:convert';
import 'dart:developer';

import 'package:appalimentacion/app/data/model/datos_alimentacion.dart';
import 'package:appalimentacion/app/data/model/local_project.dart';
import 'package:appalimentacion/app/data/model/project.dart';
import 'package:appalimentacion/app/data/model/vista_lista_response.dart';
import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/app/data/services/datos_alimentacion_service.dart';
import 'package:appalimentacion/app/data/services/vista_lista_service.dart';
import 'package:flutter/material.dart';

class ProjectsProvider extends ChangeNotifier {
  ProjectsProvider({@required this.prefs}) {
    // getLocalProjects();
  }

  final projectService = VistaListaService();
  final detailService = TipoDocService();

  final UserPreferences prefs;

  int codeProjectSelected;

  List<Project> localProjects = [];
  Map<String, DatosAlimentacion> projectDetails = {};
  Map<String, ProjectCache> projectsCache = {};

  Map<String, dynamic> error = {'error': false, 'message': 'Algo salió mal'};

  Future<void> getLocalProjects() async {
    final localData = prefs.projects;
    localProjects = vistaListaResponseFromJson(localData);
  }

  Future<void> getAndUpdateProjects() async {
    await getDataFromLocalStorage();
  }

  Future<void> getRemoteProjects() async {
    final projects = await projectService.getProjects();
    localProjects = projects;
  }

  Future<void> getProjectDetails(int projectId) async {
    try {
      final detail = await detailService.getDatosAlimentacion(
          codigoProyecto: '$projectId');
      inspect(detail);
      codeProjectSelected = projectId;
      projectDetails['$projectId'] = detail;
    } catch (_) {
      error = {
        'error': true,
        'message': 'No se puedo obtener los detalles del proyecto'
      };
    }
  }

  Future<void> getLocalProjectDetail(int projectId) async {
    try {
      final data = prefs.projects;
      // TODO
      final dataDecoded = jsonDecode(data);
      inspect(dataDecoded);
      inspect(datosAlimentacionFromJson(dataDecoded[0]));
    } catch (_) {
      error = {
        'error': true,
        'message': 'No se puedo obtener los detalles del proyecto'
      };
    }
  }

  Future<void> getDataFromLocalStorage() async {
    final localProjectsString = prefs.projects;

    if (localProjectsString != '') {
      localProjects = vistaListaResponseFromJson(localProjectsString);
    }
  }

  Future<void> saveInLocalStorage() async {
    print('saving local projects');
    prefs.projects = vistaListaResponseToJson(localProjects);
    prefs.projectsDetail = projetsDetailToJson(projectDetails.values.toList());
    prefs.projectsCache = projectsCacheToJson(projectsCache.values.toList());
  }

  Future<void> cambiarPasoProyecto(int projectCode, int numeroPaso) async {
    if (projectsCache.containsKey('$projectCode')) {
      projectsCache['$projectCode'] = projectsCache['$projectCode'].copyWith(
        stepNumber: numeroPaso,
      );
    } else {
      projectsCache['$projectCode'] = ProjectCache(stepNumber: numeroPaso);
    }

    saveInLocalStorage();
  }

  ProjectCache getProjectCache(int projectCode) {
    if (projectsCache.containsKey('$projectCode')) {
      return projectsCache['$projectCode'];
    } else {
      projectsCache['$projectCode'] = ProjectCache(stepNumber: 0);
      return projectsCache['$projectCode'];
    }
  }
}
