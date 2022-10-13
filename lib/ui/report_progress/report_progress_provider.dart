import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ReportarAvanceProvider extends ChangeNotifier {
  ReportarAvanceProvider({
    @required this.project,
    @required this.detail,
    @required ProjectCache cache,
    @required ProjectsCacheRepository projectsCacheRepository,
  })  : _projectsCacheRepository = projectsCacheRepository,
        _cache = cache {
    activitiesProgress = cache.activitiesProgress ?? {};
    filteredActivites = [...detail.actividades];
    achievesAndDifficulties = cache.qualitativesProgress ?? [];

    cacheActivities = detail.actividades;

    aspectSelected = detail.apectosEvaluar.first;

    // calculateExecutedValuePercentage();
  }

  final Project project;
  final DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  ProjectCache _cache;

  List<TipoDoc> listaTipoDoc = [];
  List<TextEditingController> textFieldControllers = [];
  List<QualitativeProgress> achievesAndDifficulties = [];
  List<RangeIndicator> rangeIndicators = [];

  int get projectCode => project.codigoproyecto;
  int get stepNumber => _cache.stepNumber;
  ProjectCache get cache => _cache;

  set cache(ProjectCache cache) {
    this._cache = cache;
  }

  List<Actividad> filteredActivites;
  AspectoEvaluar aspectSelected;

  void changeAndSaveStep(int step) {
    this.cache = this._cache.copyWith(stepNumber: step);
    _projectsCacheRepository.saveProjectCache(projectCode, this._cache);

    notifyListeners();
  }

  Map<String, dynamic> activitiesProgress = {};
  List<Actividad> cacheActivities = [];

  Future<void> saveValue(int activityId, String value) async {
    print('$activityId $value');
    activitiesProgress[activityId.toString()] = value;

    // calculateExecutedValuePercentage();

    this.cache = this._cache.copyWith(activitiesProgress: activitiesProgress);

    await _projectsCacheRepository.saveProjectCache(projectCode, this.cache);
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

  void updateAspectSelected(AspectoEvaluar aspect) {
    print(aspect.descripcionAspectoEvaluar);
    this.aspectSelected = aspect;
    notifyListeners();
  }

  void addQualitativeProgress({String achive, String difficulty}) {
    achievesAndDifficulties.add(QualitativeProgress(
      aspectToEvaluateId: aspectSelected.aspectoEvaluarId,
      title: aspectSelected.descripcionAspectoEvaluar,
      achive: achive,
      difficulty: difficulty,
    ));
    notifyListeners();

    _projectsCacheRepository.saveProjectCache(
        projectCode,
        this
            ._cache
            .copyWith(qualitativesProgress: this.achievesAndDifficulties));
  }

  void removeQualitativeProgress(int index) {
    achievesAndDifficulties.removeAt(index);

    notifyListeners();
    _projectsCacheRepository.saveProjectCache(
      projectCode,
      _cache.copyWith(qualitativesProgress: achievesAndDifficulties),
    );
  }

  onChangedRangeIndicatorCard({@required int index, @required String value}) {
    // TODO: save input value to indicator in cache
    final RangeIndicator indicator = rangeIndicators[index];

    double cantidadEjecutadaInicial = indicator.cantidadEjecutadaInicial;
    double cantidadEjecutada = indicator.cantidadEjecutada;
    double cantidadProgramada = indicator.cantidadProgramada;

    rangeIndicators[index] = indicator.copyWith(
      cantidadEjecutada: cantidadEjecutadaInicial + double.parse(value),
      porcentajeAvance: cantidadEjecutada / cantidadProgramada * 100,
    );

    notifyListeners();

    // TODO: save indicator in cache
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

    this.cache = this._cache.copyWith(
          porcentajeValorEjecutado: porcentajeValorEjecutado,
          newExecutedValue: newExecutedValue,
        );

    _projectsCacheRepository.saveProjectCache(
      projectCode,
      this.cache,
    );
  }

  bool registerDelayFactors() {
    calculateExecutedValuePercentage();
    final porcentajeEsperado = _cache.porcentajeValorProyectadoSeleccionado -
        detail.limitePorcentajeAtraso;

    if (_cache.porcentajeValorEjecutado < porcentajeEsperado) {
      return true;
    } else {
      return false;
    }
  }
}
