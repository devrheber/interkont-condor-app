import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../../domain/repository/cache_repository.dart';
import '../../../../helpers/activities_helpers.dart';

class FirstStepProvider extends ChangeNotifier {
  FirstStepProvider({
    required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    project = _projectsCacheRepository.getProject();
    cache = _projectsCacheRepository.getCache() ??
        ProjectCache(projectCode: project.codigoproyecto);
    detail = _projectsCacheRepository.getDetail(cache.projectCode)!;
    activitiesProgress = cache.activitiesProgress ?? {};
    filteredActivites = [...detail.actividades];

    validateValueActivities();
    calculateExecutedValuePercentage();
  }

  late Project project;
  late ProjectCache cache;
  late DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;

  Map<String, dynamic> activitiesProgress = {};
  late List<Actividad> filteredActivites;
  String txtBuscarAvance = '';

  Future<void> saveValue(int activityId, String value) async {
    activitiesProgress[activityId.toString()] = value;

    this.cache = this.cache.copyWith(activitiesProgress: activitiesProgress);

    calculateExecutedValuePercentage();

    notifyListeners();
  }

  void calculateExecutedValuePercentage() {
    final activities = this.detail.actividades;
    double valoresEjecutados = 0;
    double valorProyecto = 0; // Valor Proyectado
    for (int i = 0; i < activities.length; i++) {
      valoresEjecutados += activities[i].valorEjecutado;
      valorProyecto += activities[i].valorProgramado;
    }

    debugPrint('valoresEjecutados $valoresEjecutados');
    debugPrint('valoresProgramado $valorProyecto');

    double porcentajeInicial = valoresEjecutados / valorProyecto * 100;

    debugPrint('Porcentaje Avance: $porcentajeInicial');

    // Porcentaje Nuevo avance

    double nuevoValorEjecutado = 0.0;

    inspect(activitiesProgress);

    double porcentajeNuevoValorEjectuado = 0.0;

    double totalPorcentajeEjectuaado = 0.0;

    for (int i = 0; i < activities.length; i++) {
      if (activitiesProgress.containsKey(activities[i].getStringId)) {
        nuevoValorEjecutado += activities[i].valorProgramado *
            (double.parse(activitiesProgress[activities[i].getStringId]) / 100);
      }

      debugPrint('NuevoValor Ejecutado: $nuevoValorEjecutado');

      porcentajeNuevoValorEjectuado =
          (nuevoValorEjecutado / valorProyecto) * 100;

      debugPrint('Nuevo Porcentaje de Avance: $porcentajeNuevoValorEjectuado');

      debugPrint(
          'Total porcentaje ejectuado: ${(porcentajeInicial + porcentajeNuevoValorEjectuado)}');
      totalPorcentajeEjectuaado =
          porcentajeInicial + porcentajeNuevoValorEjectuado;
    }

    this.cache = this.cache.copyWith(
          porcentajeValorEjecutado: totalPorcentajeEjectuaado,
        );

    _projectsCacheRepository.saveCache(this.cache);
  }

  void filter(String value) {
    this.filteredActivites = detail.actividades
        .where(
          (element) => ActivitiesHelpers.replaceAccent(
                  element.descripcionActividad.toLowerCase())
              .contains(
            value.toLowerCase(),
          ),
        )
        .toList();
    notifyListeners();
  }

  void validateValueActivities() {
    if (cache.activitiesProgress == null) return;
    for (final item in detail.actividades) {
      String faltantePorEjecutar = item.faltantePorEjecutar(
          double.tryParse(cache.activitiesProgress![item.getStringId] ?? '0') ??
              0.0);

      if (double.parse(faltantePorEjecutar.replaceAll(' %', '')) < 0 ||
          double.parse(faltantePorEjecutar.replaceAll(' %', '')) > 100) {
        cache.activitiesProgress![item.getStringId] = '0';
      }
    }

    _projectsCacheRepository.saveCache(this.cache);
  }
}
