import 'dart:async';

import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/project_helpers.dart';
import 'package:flutter/material.dart';

class ProjectDetailProvider extends ChangeNotifier {
  ProjectDetailProvider({
    this.project,
    this.detail,
    @required final UserPreferences prefs,
    @required this.projectRepository,
    @required this.projectsCacheRepository,
  }) : _prefs = prefs {
    _getPosicionPeriodoSeleccionado();

    _init();
  }

  final Project project;
  DatosAlimentacion detail;
  final UserPreferences _prefs;
  final ProjectsRepository projectRepository;
  final ProjectsCacheRepository projectsCacheRepository;

  ProjectCache cache = ProjectCache();
  int _ultimaSincro;

  int posicionPeriodoReportado = 0;

  int get ultimaSincro => _ultimaSincro;

  set ultimaSincro(int value) {
    _ultimaSincro = value;
    if (value == 1) {
      Timer(const Duration(seconds: 10), () {
        _ultimaSincro = null;
        try {
          notifyListeners();
        } catch (_) {}
      });
    }
    notifyListeners();
  }

  _init() {
    projectsCacheRepository.getProjectsCache().listen((map) {
      final cache = map[project.codigoproyecto.toString()];

      if (this.cache != cache) {
        this.cache = cache;
        notifyListeners();
        _getPosicionPeriodoSeleccionado();
      }
    });
  }

  Map<String, DatosAlimentacion> projectDetails = {};

  void _getPosicionPeriodoSeleccionado() {
    final index = this.detail.periodos.indexWhere(
        (periodo) => periodo.periodoId == this.cache.periodoIdSeleccionado);

    if (index < 0) return;
    posicionPeriodoReportado = index;
  }

  Future<bool> syncDetail() async {
    final projectCode = project.codigoproyecto;

    try {
      final detail = await projectRepository.getDatosAlimentacion(
          codigoProyecto: '$projectCode');

      _saveDetail(projectCode, detail);
      final dateSync = ProjectHelpers.setUltimaFechaSincro();
      _saveCache(cache: cache.copyWith(ultimaFechaSincro: dateSync));

      this.detail = detail;
      ultimaSincro = 1;

      return true;
    } catch (_) {
      return false;
    }
  }

  void _saveDetail(int codigoProyecto, DatosAlimentacion data) {
    final key = codigoProyecto.toString();
    Map<String, DatosAlimentacion> map = {};

    final details = _prefs.projectsDetail;

    if (details == '') {
      map = {key: data};
    } else {
      map = projectsDetailFromJson(details);
      map[key] = data;
    }

    _prefs.projectsDetail = projetsDetailToJson(map);
  }

  void _saveCache({@required ProjectCache cache}) {
    final key = project.codigoproyecto.toString();

    projectsCacheRepository.saveProjectCache(key, cache);
  }

  void cambiarPosicionPeriodoReportado(nuevaPosicion) {
    final periodo = this.detail.periodos[nuevaPosicion];

    final cache = this.cache.copyWith(
          periodoIdSeleccionado: periodo.periodoId,
          porcentajeValorProyectadoSeleccionado: periodo.porcentajeProyectado,
        );

    _saveCache(cache: cache);

    posicionPeriodoReportado = nuevaPosicion;

    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => notifyListeners());
  }
}
