import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/activities_helpers.dart';
import 'package:flutter/material.dart';

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

    double totalCantidadProgramada = 0;
    double valorEjecucionProyecto = 0;

    for (int i = 0; i < activities.length; i++) {
      if (activitiesProgress.containsKey(activities[i].getStringId)) {
        /// Ir sumando lo que representa el porcentaje ingresado en [Avance actual]
        valorEjecucionProyecto += activities[i].getNewExecutedValue(
            double.parse(activitiesProgress[activities[i].getStringId]));
      }

      /// Se obtiene el total de cantidad programada para el proyecto
      /// Sumar los valores programados de las actividades
      totalCantidadProgramada += activities[i].cantidadProgramada;
    }

    // A lo que representa el nuevo valor ejecutado se le suma el valor ejecutado
    // registrado en reportes previos.
    valorEjecucionProyecto += calculateRemoteExecutedValuePercentage();

    // Se obtiene el porcentaje del valor ejecutado considerando los registros anteriores
    // y el registro actual
    final porcentajeValorEjecutado =
        (valorEjecucionProyecto / totalCantidadProgramada);

    final newExecutedValue = project.valorproyecto * porcentajeValorEjecutado;

    this.cache = this.cache.copyWith(
          porcentajeValorEjecutado: porcentajeValorEjecutado,
          newExecutedValue: newExecutedValue,
        );

    _projectsCacheRepository.saveCache(this.cache);
  }

  double calculateRemoteExecutedValuePercentage() {
    final activities = this.detail.actividades;

    double valorEjecucionProyecto = 0;

    for (int i = 0; i < activities.length; i++) {
      valorEjecucionProyecto += activities[i].getNewExecutedValue(
          (activities[i].cantidadEjecutada / activities[i].cantidadProgramada) *
              100);
    }

    return valorEjecucionProyecto;
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
      double.parse(faltantePorEjecutar.replaceAll(' %', '')) > 100
      ) {
        cache.activitiesProgress![item.getStringId] = '0';
      }
    }

    _projectsCacheRepository.saveCache(this.cache);
  }
}
