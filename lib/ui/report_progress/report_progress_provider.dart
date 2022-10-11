import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ReportarAvanceProvider extends ChangeNotifier {
  ReportarAvanceProvider({
    @required this.project,
    @required this.detail,
    @required this.cache,
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
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
  ProjectCache cache;

  List<TextEditingController> textFieldControllers = [];

  List<QualitativeProgress> achievesAndDifficulties = [];
  List<RangeIndicator> rangeIndicators = [];
  List<File> listaImagenes = [];
  List<File> listaDocumentos = [];
  List<TipoDoc> listaTipoDoc = [];

  String get projectCode => project.codigoproyecto.toString();

  List<Actividad> filteredActivites;
  AspectoEvaluar aspectSelected;

  void changeAndSaveStep(int step) {
    this.cache = this.cache.copyWith(stepNumber: step);

    _projectsCacheRepository.saveProjectCache(projectCode, this.cache);

    notifyListeners();
  }

  Map<String, dynamic> activitiesProgress = {};
  List<Actividad> cacheActivities = [];

  Future<void> saveValue(int activityId, String value) async {
    print('$activityId $value');
    activitiesProgress[activityId.toString()] = value;
    this.cache = cache.copyWith(activitiesProgress: activitiesProgress);

    // calculateExecutedValuePercentage();

    await _projectsCacheRepository.saveProjectCache(projectCode, cache);
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
    this.cache =
        this.cache.copyWith(qualitativesProgress: this.achievesAndDifficulties);
    _projectsCacheRepository.saveProjectCache(projectCode, this.cache);
  }

  void removeQualitativeProgress(int index) {
    achievesAndDifficulties.removeAt(index);
    this.cache = cache.copyWith(qualitativesProgress: achievesAndDifficulties);
    notifyListeners();
    _projectsCacheRepository.saveProjectCache(projectCode, this.cache);
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
      valorEjecucionProyecto += activities[i].getNewExecutedValue(double.parse(
          cache.activitiesProgress[activities[i].actividadId.toString()]));
      totalCantidadProgramada += activities[i].cantidadProgramada;
    }

    final porcentajeValorEjecutado =
        (valorEjecucionProyecto / totalCantidadProgramada);

    final newExecutedValue = project.valorproyecto * porcentajeValorEjecutado;

    this.cache = this.cache.copyWith(
          porcentajeValorEjecutado: porcentajeValorEjecutado,
          newExecutedValue: newExecutedValue,
        );
  }
}
