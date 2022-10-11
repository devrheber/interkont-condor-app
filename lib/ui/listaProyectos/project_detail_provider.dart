import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/project_helpers.dart';
import 'package:flutter/material.dart';

class ProjectDetailProvider extends ChangeNotifier {
  ProjectDetailProvider({
    @required this.project,
    @required this.detail,
    @required this.cache,
    @required this.projectRepository,
    @required this.projectsCacheRepository,
  }) {
    _getPosicionPeriodoSeleccionado();

    cache = cache.copyWith(projectCode: project.codigoproyecto);
  }

  int get projectCode => project.codigoproyecto;

  final Project project;
  DatosAlimentacion detail;
  final ProjectsRepository projectRepository;
  final ProjectsCacheRepository projectsCacheRepository;

  ProjectCache cache;
  int _ultimaSincro;

  Periodo periodoSeleccionado;

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

  Map<String, DatosAlimentacion> projectDetails = {};

  void _getPosicionPeriodoSeleccionado() {
    final index = this.detail.periodos.indexWhere(
        (periodo) => periodo.periodoId == this.cache?.periodoIdSeleccionado);

    if (index < 0) return;
    periodoSeleccionado = detail.periodos[index];
  }

  Future<bool> syncDetail() async {
    final projectCode = project.codigoproyecto;

    try {
      final detail = await projectRepository.getDatosAlimentacion(
          codigoProyecto: '$projectCode');

      final dateSync = ProjectHelpers.setUltimaFechaSincro();

      this.cache = cache.copyWith(ultimaFechaSincro: dateSync);
      this.detail = detail;

      ultimaSincro = 1;

      projectsCacheRepository.saveProjectCache(
          projectCode.toString(), this.cache);

      return true;
    } catch (_) {
      return false;
    }
  }

  void cambiarPeriodoReportado(Periodo periodo) {
    this.cache = this.cache.copyWith(
          periodoIdSeleccionado: periodo.periodoId,
          porcentajeValorProyectadoSeleccionado: periodo.porcentajeProyectado,
        );

    projectsCacheRepository.saveProjectCache(projectCode.toString(), cache);

    periodoSeleccionado = periodo;

    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => notifyListeners());
  }
}
