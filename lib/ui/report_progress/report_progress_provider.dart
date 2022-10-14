import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:flutter/material.dart';

class ReportProgressProvider extends ChangeNotifier {
  ReportProgressProvider({
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    cache = projectsCacheRepository.getCache();
    project = projectsCacheRepository.getProject();

    detail = projectsCacheRepository.getDetail(project.codigoproyecto);

    achievesAndDifficulties = cache.qualitativesProgress ?? [];

    aspectSelected = detail.apectosEvaluar.first;

    _init();
    _initFourthStep();
  }

  Project project;
  DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  ProjectCache cache;

  List<TipoDoc> listaTipoDoc = [];
  List<TextEditingController> textFieldControllers = [];
  List<QualitativeProgress> achievesAndDifficulties = [];
  List<RangeIndicator> rangeIndicators = [];

  int get stepNumber => cache.stepNumber;

  AspectoEvaluar aspectSelected;

  StreamSubscription<Map<String, ProjectCache>> cacheSubscription;

  /// Actualiza el objeto si fué modificado por un provider en un nivel inferior
  _init() {
    cacheSubscription =
        _projectsCacheRepository.getProjectsCache().listen((cache) {
      this.cache = cache[project.getProjectCode];
      _initFourthStep();
    });
  }

  @override
  void dispose() {
    cacheSubscription.cancel();
    super.dispose();
  }

  void changeAndSaveStep(int step) {
    this.cache = this.cache.copyWith(stepNumber: step);
    _projectsCacheRepository.saveCache(this.cache);

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

  bool registerDelayFactors() {
    // calculateExecutedValuePercentage();
    final porcentajeEsperado = cache.porcentajeValorProyectadoSeleccionado -
        detail.limitePorcentajeAtraso;

    if (cache.porcentajeValorEjecutado < porcentajeEsperado) {
      return true;
    } else {
      return false;
    }
  }

  DateTime incomeGenerationDate;
  DateTime rentalRepaymentDate;
  String generatedReturns;
  String currentMonthReturns;
  String pastDueMonthReturns;

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

  double _getDoubleValue(String value) {
    String rawValue = value == '' ? '0' : value;
    rawValue = rawValue.replaceAll('\COP', '');
    rawValue = rawValue.replaceAll('.', '');
    rawValue = rawValue.replaceAll(',', '.');
    return double.parse(rawValue);
  }

  bool get secondButtonValidation {
    if (stepNumber == 2) {
      return achievesAndDifficulties.isEmpty;
    }

    if (stepNumber == 3) {
      return incomeGenerationDate == null ||
          rentalRepaymentDate == null ||
          generatedReturns == null ||
          currentMonthReturns == null ||
          pastDueMonthReturns == null ||
          generatedReturns.isEmpty ||
          currentMonthReturns.isEmpty ||
          pastDueMonthReturns.isEmpty;
    }

    return false;
  }

  String stepValidations() {
    switch (stepNumber) {
      case 2:
        if (achievesAndDifficulties.isEmpty) {
          return 'Añada al menos un avance cualitativo';
        }

        return null;
      case 3:
        if (incomeGenerationDate == null ||
            rentalRepaymentDate == null ||
            generatedReturns == null ||
            currentMonthReturns == null ||
            pastDueMonthReturns == null ||
            generatedReturns.isEmpty ||
            currentMonthReturns.isEmpty ||
            pastDueMonthReturns.isEmpty) {
          return 'Complete los indicadores de rendimiento';
        }

        return null;

      default:
        return null;
    }
  }
}
