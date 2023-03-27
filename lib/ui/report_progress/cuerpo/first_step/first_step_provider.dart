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

    // TOOD
    // validateValueActivities();
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

    cache = cache.copyWith(activitiesProgress: activitiesProgress);

    calculateExecutedValuePercentage();

    notifyListeners();
  }

  void calculateExecutedValuePercentage() {
    final activities = detail.actividades;
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

    double totalPorcentajeEjectuado = 0.0;

    for (int i = 0; i < activities.length; i++) {
      if (activitiesProgress.containsKey(activities[i].getStringId)) {
        nuevoValorEjecutado += activities[i].valorProgramado *
            (double.parse(activitiesProgress[activities[i].getStringId]));
      }

      debugPrint('NuevoValor Ejecutado: $nuevoValorEjecutado');

      porcentajeNuevoValorEjectuado =
          (nuevoValorEjecutado / valorProyecto) * 100;

      debugPrint('Nuevo Porcentaje de Avance: $porcentajeNuevoValorEjectuado');

      debugPrint(
          'Total porcentaje ejectuado: ${(porcentajeInicial + porcentajeNuevoValorEjectuado)}');
      totalPorcentajeEjectuado =
          porcentajeInicial + porcentajeNuevoValorEjectuado;
    }

    cache = cache.copyWith(
      porcentajeValorEjecutado: totalPorcentajeEjectuado,
    );

    _projectsCacheRepository.saveCache(cache);
  }

  void filter(String value) {
    filteredActivites = detail.actividades
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
}
