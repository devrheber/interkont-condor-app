import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/activities_helpers.dart';
import 'package:flutter/material.dart';

class FirstStepProvider extends ChangeNotifier {
  FirstStepProvider({
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    cache = _projectsCacheRepository.getCache();
    detail = _projectsCacheRepository.getDetail(cache.projectCode);
    project = _projectsCacheRepository.getProject();
    activitiesProgress = cache.activitiesProgress ?? {};
    filteredActivites = [...detail.actividades];

    calculateExecutedValuePercentage();
  }

  Project project;
  ProjectCache cache;
  DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;

  Map<String, dynamic> activitiesProgress = {};
  List<Actividad> filteredActivites;
  String txtBuscarAvance = '';

  Future<void> saveValue(int activityId, String value) async {
    activitiesProgress[activityId.toString()] = value;

    this.cache = this.cache.copyWith(activitiesProgress: activitiesProgress);

    calculateExecutedValuePercentage();

    notifyListeners();
  }

  void calculateExecutedValuePercentage() {
    final activities = this.detail.actividades;

    double totalCantidadProgramada = 0;
    double valorEjecucionProyecto = 0;

    for (int i = 0; i < activities.length; i++) {
      if (activitiesProgress
          .containsKey(activities[i].actividadId.toString())) {
        valorEjecucionProyecto += activities[i].getNewExecutedValue(
            double.parse(
                activitiesProgress[activities[i].actividadId.toString()]));
      }
      totalCantidadProgramada += activities[i].cantidadProgramada;
    }

    final porcentajeValorEjecutado =
        (valorEjecucionProyecto / totalCantidadProgramada);

    final newExecutedValue = project.valorproyecto * porcentajeValorEjecutado;

    this.cache = this.cache.copyWith(
          porcentajeValorEjecutado: porcentajeValorEjecutado,
          newExecutedValue: newExecutedValue,
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
}
