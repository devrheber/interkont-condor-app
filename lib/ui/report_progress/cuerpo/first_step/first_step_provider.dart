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
    double totalValorProgramada = 0.0;
    for (int i = 0; i < activities.length; i++) {
      totalValorProgramada += activities[i].valorProgramado;
    }
    double totalPorcentajeEjecutado = 0;
    for (int i = 0; i < activities.length; i++) {
      final activity = activities[i];
      final porcentajeActividad =
          activities[i].valorProgramado / totalValorProgramada;

      final totalCantidadEjecutada = activity.cantidadEjecutada +
          (activitiesProgress.containsKey(activity.getStringId)
              ? double.parse(activitiesProgress[activity.getStringId])
              : 0);

      /// porcentaje de avance de la actividad
      final porcentajeAvanceActividad =
          totalCantidadEjecutada / activity.cantidadProgramada;

      /// cuánto representa la cantidad de avance actual según el porcentaje de la actividad
      final nuevoPorcentajeEjecutado =
          porcentajeActividad * porcentajeAvanceActividad;

      totalPorcentajeEjecutado += nuevoPorcentajeEjecutado;
    }

    totalPorcentajeEjecutado *= 100;
    
    cache = cache.copyWith(
      porcentajeValorEjecutado: totalPorcentajeEjecutado,
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
