import 'dart:developer';
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
    // TODO Manejar execption si las listas llegaran vacías
    activitiesProgress = cache.activitiesProgress;
    filteredActivites = [...detail.actividades];
    achievesAndDifficulties = cache.qualitativesProgress;
    aspectSelected = detail.apectosEvaluar.first;

    // TODO rangeIncicator = details.indicadoresAlcance
  }

  final Project project;
  final DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  ProjectCache cache;
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

  void saveValue(int activityId, String value) {
    activitiesProgress[activityId.toString()] = value;
    this.cache = cache.copyWith(activitiesProgress: activitiesProgress);
    _projectsCacheRepository.saveProjectCache(projectCode, cache);

    calculateExecutedValue();
  }

  void saveFirstStep() {
    inspect(activitiesProgress);
    _projectsCacheRepository.saveProjectCache(
        projectCode,
        cache.copyWith(
          activitiesProgress: activitiesProgress,
        ));
  }

  void filter(String value) {
    this.filteredActivites = [
      ...detail.actividades
          .where(
            (element) => element.descripcionActividad.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList()
    ];
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

  void calculateExecutedValue() {
    double newExecutedValue = 0.0;
    double newExecutedPorcentageValue = 0.0;

    for (int i = 0; i < detail.actividades.length; i++) {
      newExecutedValue += detail.actividades[i].valorEjecutado;
    }
    newExecutedPorcentageValue =
        (newExecutedValue / project.valorejecutado) * 100;
    this.cache = cache.copyWith(
      porcentajeValorEjecutado: newExecutedPorcentageValue,
      newExecutedValue: newExecutedValue,
    );
  }
}
