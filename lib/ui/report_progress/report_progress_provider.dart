import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/utils/datetime_format.dart';
import 'package:flutter/material.dart';

class ReportProgressProvider extends ChangeNotifier {
  ReportProgressProvider({
    required ProjectsCacheRepository projectsCacheRepository,
    required FilesPersistentCacheRepository filesPersistentCacheRepository,
    required this.periodoSeleccionado,
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
  final Periodo periodoSeleccionado;

  int get stepNumber => cache.stepNumber;

  late AspectoEvaluar aspectSelected;

  StreamSubscription<Map<String, ProjectCache>>? cacheSubscription;
  StreamSubscription<Map<String, DatosAlimentacion>>? detailsSubscription;

  DateTime? incomeGenerationDate;
  DateTime? rentalRepaymentDate;
  double? generatedReturns;
  double? valorReintegroRendimientos;
  double? valorSaldoFinalExtracto;

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

    if (((cache.porcentajeValorEjecutado ?? 0)) < porcentajeEsperado) {
      return true;
    } else {
      return false;
    }
  }

  void _initFourthStep() {
    incomeGenerationDate = this.cache.getIncomeGenerationDate;
    rentalRepaymentDate = this.cache.getRentalRepaymentDate;
    generatedReturns = this.cache.generatedReturns;
    valorReintegroRendimientos = this.cache.valorReintegroRendimientos;
    valorSaldoFinalExtracto = this.cache.valorSaldoFinalExtracto;

    notifyListeners();
  }

  void saveIncomeGenerationDate(DateTime value) {
    incomeGenerationDate = value;
    final dateString = DateTimeFormat.yyyyMMDD(value);
    this.cache = this.cache.copyWith(incomeGenerationDate: dateString);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveRentalRepaymentDate(DateTime value) {
    rentalRepaymentDate = value;
    final dateString = DateTimeFormat.yyyyMMDD(value);
    this.cache = this.cache.copyWith(rentalRepaymentDate: dateString);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveGeneratedReturns(double value) {
    generatedReturns = value;
    this.cache = this.cache.copyWith(generatedReturns: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveValorReintegroRendimientos(double value) {
    valorReintegroRendimientos = value;
    this.cache = this.cache.copyWith(valorReintegroRendimientos: value);
    _projectsCacheRepository.saveCache(this.cache);
  }

  void saveValorSaldoFinalExtracto(double value) {
    valorSaldoFinalExtracto = value;
    this.cache = this.cache.copyWith(valorSaldoFinalExtracto: value);
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
