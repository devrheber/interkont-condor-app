import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/repository/cache_repository.dart';
import '../../domain/repository/projects_repository.dart';

class ProjectDetailProvider extends ChangeNotifier {
  ProjectDetailProvider({
    required this.projectRepository,
    required this.projectsCacheRepository,
  }) {
    project = projectsCacheRepository.getProject();
    detail = projectsCacheRepository.getDetail(project.codigoproyecto);
    cache = projectsCacheRepository.getCache() ??
        ProjectCache(projectCode: project.codigoproyecto);

    cache = cache.copyWith(projectCode: project.codigoproyecto);
    _getPosicionPeriodoSeleccionado();
    syncDetail();
  }

  GlobalKey titleCardKey = GlobalKey<State<StatefulWidget>>();

  int get projectCode => project.codigoproyecto;

  late Project project;
  DatosAlimentacion? detail;
  final ProjectsRepository projectRepository;
  final ProjectsCacheRepository projectsCacheRepository;

  late ProjectCache _cache;
  Periodo? periodoSeleccionado;

  CancelToken? cancelToken;

  ProjectCache get cache => _cache;

  set cache(ProjectCache value) {
    _cache = value;

    Future.delayed(const Duration(seconds: 61)).then((_) {
      if (!(titleCardKey.currentState?.mounted ?? false)) return;

      notifyListeners();
    });
  }

  Map<String, DatosAlimentacion> projectDetails = {};

  void _getPosicionPeriodoSeleccionado() {
    final index = this.detail?.periodos.indexWhere(
        (periodo) => periodo.periodoId == this.cache.periodoIdSeleccionado);

    if ((index ?? -1) < 0) return;
    periodoSeleccionado = detail?.periodos[index!];
  }

  Future<bool> syncDetail() async {
    final projectCode = project.codigoproyecto;
    cancelToken = CancelToken();

    try {
      final detail = await projectRepository.getDatosAlimentacion(
        codigoProyecto: '$projectCode',
        cancelToken: cancelToken,
      );

      _updateSelectedPeriod();

      final dateSync = DateTime.now();

      this.cache = this.cache.copyWith(lastSyncDate: dateSync);
      this.detail = detail;

      if (!(titleCardKey.currentState?.mounted ?? false)) return false;

      notifyListeners();

      projectsCacheRepository.saveProjectCache(projectCode, this.cache);
      projectsCacheRepository.saveDetail(detail);

      return true;
    } catch (_) {
      return false;
    }
  }

  void _updateSelectedPeriod() {
    final int index = detail!.periodos.indexWhere(
        (period) => period.periodoId == periodoSeleccionado?.periodoId);

    if (index < 0) {
      periodoSeleccionado = null;
      return;
    }

    periodoSeleccionado = detail?.periodos[index];
  }

  void cambiarPeriodoReportado(Periodo? periodo) {
    if (periodo == null) return;
    this.cache = this.cache.copyWith(
          periodoIdSeleccionado: periodo.periodoId,
          porcentajeValorProyectadoSeleccionado: periodo.porcentajeProyectado,
        );

    projectsCacheRepository.saveProjectCache(projectCode, cache);

    periodoSeleccionado = periodo;

    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => notifyListeners());
  }

  void updateProject() {
    project = projectsCacheRepository.getProject();
  }

  void updateStepToPendingPublish() {
    if (cache.stepNumber != 4) return;
    this.cache = this.cache.copyWith(stepNumber: 4);
    projectsCacheRepository.saveCache(this.cache);
  }

  void clearPeriodoSeleccionado() {
    periodoSeleccionado = null;
    notifyListeners();
  }
}
