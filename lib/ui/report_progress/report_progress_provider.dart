import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ReportarAvanceProvider extends ChangeNotifier {
  ReportarAvanceProvider({
    @required this.project,
    @required this.detail,
    @required ProjectsCacheRepository projectsCacheRepository,
    @required this.cache,
  }) : _projectsCacheRepository = projectsCacheRepository {
    // TODO Manejar execption si las listas llegaran vacías
    filteredActivites = detail.actividades;
    aspectSelected = detail.apectosEvaluar.first;
    // TODO achievesAndDifficulties from Cache
  }

  final Project project;
  final DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  ProjectCache cache;
  List<QualitativeProgress> achievesAndDifficulties = [];

  List<Actividad> filteredActivites;
  AspectoEvaluar aspectSelected;

  void changeAndSaveStep(int step) {
    this.cache = this.cache.copyWith(stepNumber: step);

    _projectsCacheRepository.saveProjectCache(
        project.codigoproyecto.toString(), this.cache);

    notifyListeners();
  }

  Map<String, String> activitiesProgress = {};

  void saveValue(int activityId, String value) {
    // TODO save value in cache
    print('$activityId {"value": $value}');
    activitiesProgress[activityId.toString()] = value;
  }

  void saveFirstStep() {
    print('guardando primer paso');
    _projectsCacheRepository.saveProjectCache(
        project.codigoproyecto.toString(),
        cache.copyWith(
          activitiesProgress: activitiesProgress,
        ));
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
    // TODO save list in cache;
  }

  void removeQualitativeProgress(int index) {
    achievesAndDifficulties.removeAt(index);
    notifyListeners();
    // TODO save list in cache
  }
}
