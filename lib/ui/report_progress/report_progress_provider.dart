import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/repository/cache_repository.dart';
import '../../domain/repository/files_persistent_cache_repository.dart';
import 'package:sentry/sentry.dart';

class ReportProgressProvider extends ChangeNotifier {
  ReportProgressProvider({
    required ProjectsCacheRepository projectsCacheRepository,
    required FilesPersistentCacheRepository filesPersistentCacheRepository,
  })  : _projectsCacheRepository = projectsCacheRepository,
        _filesPersistentCacheRepository = filesPersistentCacheRepository {
    project = projectsCacheRepository.getProject();
    cache = projectsCacheRepository.getCache() ??
        ProjectCache(projectCode: project.codigoproyecto);

    detail = projectsCacheRepository.getDetail(project.codigoproyecto)!;

    achievesAndDifficulties = cache.qualitativesProgress ?? [];

    rangeIndicators = cache.rangeIndicators ?? {};

    aspectSelected = detail.apectosEvaluar.first;

    _init();
    _initFourthStep();
    // TODO This method is duplicate,
    // There is in FirstStepProvider and here.
    calculateExecutedValuePercentage();
  }

  late Project project;
  late DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  final FilesPersistentCacheRepository _filesPersistentCacheRepository;
  late ProjectCache cache;

  List<TipoDoc> listaTipoDoc = [];
  List<TextEditingController> textFieldControllers = [];
  List<QualitativeProgress> achievesAndDifficulties = [];
  Map<String, dynamic> rangeIndicators = {};

  int get stepNumber => cache.stepNumber;

  late AspectoEvaluar aspectSelected;

  StreamSubscription<Map<String, ProjectCache>>? cacheSubscription;
  StreamSubscription<Map<String, DatosAlimentacion>>? detailsSubscription;

  DateTime? incomeGenerationDate;
  DateTime? rentalRepaymentDate;
  String? generatedReturns = '';
  String? currentMonthReturns = '';
  String? pastDueMonthReturns = '';

  /// Actualiza el objeto si fué modificado por un provider en un nivel inferior
  _init() {
    cacheSubscription =
        _projectsCacheRepository.getProjectsCache().listen((cache) {
      this.cache = cache[project.getProjectCode] ??
          ProjectCache(projectCode: project.codigoproyecto);
      _initFourthStep();
    });

    detailsSubscription =
        _projectsCacheRepository.getDetails().listen((details) {
      final detailUpdated = details[project.getProjectCode];

      if (detailUpdated == null) return;
      if (detailUpdated == this.detail) {
        return;
      }
      this.detail = detailUpdated;
      notifyListeners();
    });

    try {
      throw Exception('Excepción de prueba para Sentry');
    } catch (exception, stackTrace) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void dispose() {
    debugPrint('dispose reportProgressProvider');
    cacheSubscription?.cancel();
    detailsSubscription?.cancel();
    super.dispose();
  }

  void changeAndSaveStep(int step) {
    if (step > 5) return;
    if (step < 1) return;
    this.cache = this.cache.copyWith(stepNumber: step);
    _projectsCacheRepository.saveCache(this.cache);

    notifyListeners();
  }

  void updateAspectSelected(AspectoEvaluar aspect) {
    print(aspect.descripcionAspectoEvaluar);
    this.aspectSelected = aspect;
    notifyListeners();
  }

  void addQualitativeProgress({String? achive, String? difficulty}) {
    achievesAndDifficulties.add(QualitativeProgress(
      aspectToEvaluateId: aspectSelected.aspectoEvaluarId,
      title: aspectSelected.descripcionAspectoEvaluar,
      achive: achive,
      difficulty: difficulty,
    ));
    notifyListeners();

    _projectsCacheRepository.saveCache(this
        .cache
        .copyWith(qualitativesProgress: this.achievesAndDifficulties));
  }

  void removeQualitativeProgress(int index) {
    achievesAndDifficulties.removeAt(index);

    notifyListeners();
    _projectsCacheRepository.saveCache(
      cache.copyWith(qualitativesProgress: achievesAndDifficulties),
    );
  }

  onChangedRangeIndicatorCard(int id, String value) {
    rangeIndicators[id.toString()] = value;
    print('indicator value: ${rangeIndicators[id.toString()]}');

    this.cache = this.cache.copyWith(rangeIndicators: rangeIndicators);

    _projectsCacheRepository.saveCache(this.cache);

    // notifyListeners();
  }

  bool registerDelayFactors() {
    // calculateExecutedValuePercentage();
    final porcentajeEsperado =
        (cache.porcentajeValorProyectadoSeleccionado ?? 0) -
            detail.limitePorcentajeAtraso;

    if (((cache.porcentajeValorEjecutado ?? 0) * 100) < porcentajeEsperado) {
      return true;
    } else {
      return false;
    }
  }

  void _initFourthStep() {
    incomeGenerationDate = this.cache.incomeGenerationDate;
    rentalRepaymentDate = this.cache.rentalRepaymentDate;
    generatedReturns = this.cache.generatedReturns;
    currentMonthReturns = this.cache.currentMonthReturns;
    pastDueMonthReturns = this.cache.pastDueMonthReturns;

    notifyListeners();
  }

  void saveIncomeGenerationDate(DateTime value) {
    incomeGenerationDate = value;
    this.cache = this.cache.copyWith(incomeGenerationDate: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveRentalRepaymentDate(DateTime value) {
    rentalRepaymentDate = value;
    this.cache = this.cache.copyWith(rentalRepaymentDate: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveGeneratedReturns(String value) {
    generatedReturns = value;
    this.cache = this.cache.copyWith(generatedReturns: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveCurrentMonthReturns(String value) {
    currentMonthReturns = value;
    this.cache = this.cache.copyWith(currentMonthReturns: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void savePastDueMonthReturns(String value) {
    pastDueMonthReturns = value;
    this.cache = this.cache.copyWith(pastDueMonthReturns: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  bool get secondButtonValidation {
    return false;
  }

  String get firstButtonTitle {
    switch (cache.stepNumber) {
      case 0:
      case 1:
        return 'Cancelar';

      default:
        return 'Retroceder';
    }
  }

  String? stepValidations() {
    switch (stepNumber) {
      case 4:
        final comment = cache.comment;

        if (comment == null || comment.isEmpty) {
          return 'El campo comentarios es obligatorio';
        }

        final mainPhoto = _filesPersistentCacheRepository.getMainPhoto();
        if (mainPhoto == null) return 'Agregue una foto principal';

        final requiredDocuments =
            _filesPersistentCacheRepository.getRequiredDocuments();
        if (requiredDocuments.isEmpty)
          return 'Agregue los documentos obligatorios';

        return null;

      default:
        return null;
    }
  }

  void calculateExecutedValuePercentage() {
    final activities = this.detail.actividades;
    double valoresEjecutados = 0;
    double valorProyecto = 0; // Valor Proyectado
    for (int i = 0; i < activities.length; i++) {
      valoresEjecutados += activities[i].valorEjecutado;
      valorProyecto += activities[i].valorProgramado;
    }

    double porcentajeInicial = valoresEjecutados / valorProyecto * 100;

    // Porcentaje Nuevo avance

    double nuevoValorEjecutado = 0.0;

    double porcentajeNuevoValorEjectuado = 0.0;

    double totalPorcentajeEjectuaado = 0.0;

    for (int i = 0; i < activities.length; i++) {
      if (this
              .cache
              .activitiesProgress
              ?.containsKey(activities[i].getStringId) ??
          false) {
        nuevoValorEjecutado += activities[i].valorProgramado *
            (double.parse(
                    this.cache.activitiesProgress![activities[i].getStringId]) /
                100);
      }

      porcentajeNuevoValorEjectuado =
          (nuevoValorEjecutado / valorProyecto) * 100;

      totalPorcentajeEjectuaado =
          porcentajeInicial + porcentajeNuevoValorEjectuado;
    }

    this.cache = this.cache.copyWith(
          porcentajeValorEjecutado: totalPorcentajeEjectuaado,
        );

    _projectsCacheRepository.saveCache(this.cache);
  }
}
