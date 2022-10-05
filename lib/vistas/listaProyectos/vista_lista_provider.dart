import 'dart:convert';
import 'dart:developer';

import 'package:appalimentacion/app/data/model/datos_alimentacion.dart';
import 'package:appalimentacion/app/data/model/local_project.dart';
import 'package:appalimentacion/app/data/services/datos_alimentacion_service.dart';
import 'package:appalimentacion/app/data/services/vista_lista_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VistaListaProvider extends ChangeNotifier {
  VistaListaProvider() {
    getUserCredentials();
    getLocalProjects();
  }

  final projectService = VistaListaService();
  final detailService = TipoDocService();

  String localProyectKey = '__local_projects__key__';
  String userDataKey = '__user_data_key__';
  String projectsDetailKey = '__projects_detail_key__';

  int codeProjectSelected;

  List<LocalProject> localProjects = [];
  Map<String, DatosAlimentacion> projectDetails = {};
  Map<String, dynamic> userDataSession = {};

  Map<String, dynamic> error = {'error': false, 'message': 'Algo salió mal'};

  Future<void> getLocalProjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final localData = prefs.getString(localProyectKey);
    localProjects = localProjectFromJson(localData);
  }

  Future<void> getProjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final projects = await projectService.getProjects();
    for (final item in projects) {
      localProjects.add(LocalProject(project: item, stepNumber: null));
    }

    await prefs.setString(localProyectKey, localProjectsToJson(localProjects));

    final localProjectsString = prefs.getString(localProyectKey) ?? '';
    if (localProjectsString != '') {
      localProjectFromJson(localProjectsString);
    }

    print(prefs.getString(userDataKey) ?? '');
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(projectsDetailKey);
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

  LocalProject getCurrentProject() {
    return localProjects.firstWhere((localProject) =>
        localProject.project.codigocategoria == codeProjectSelected);
  }

  Future<void> saveInLocalStorage() async {
    print('saving local projects');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(localProyectKey, localProjectsToJson(localProjects));
    await prefs.setString(projectsDetailKey, jsonEncode(projectDetails));
  }

  Future<void> getUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString(userDataKey));
    userDataSession = data;
  }

  Future<void> cambiarPasoProyecto(int projectCode, int numeroPaso) async {
    final indexLocalProject = localProjects
        .indexWhere((element) => element.project.codigoproyecto == projectCode);

    if (indexLocalProject < 0) return;

    localProjects[indexLocalProject] =
        localProjects[indexLocalProject].copyWith(stepNumber: numeroPaso);

    saveInLocalStorage();
  }
}
