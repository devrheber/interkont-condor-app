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

  Stream<double> get getExecutedValuePercentage =>
      _projectsCacheRepository.getExecutedValuePercentage();

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
    incomeGenerationDate = cache.getIncomeGenerationDate;
    rentalRepaymentDate = cache.getRentalRepaymentDate;
    generatedReturns = cache.generatedReturns;
    valorReintegroRendimientos = cache.valorReintegroRendimientos;
    valorSaldoFinalExtracto = cache.valorSaldoFinalExtracto;

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

        // TODO: validar documentos, segun lista de documentos obligatorios

        final requiredDocuments =
            _filesPersistentCacheRepository.getRequiredDocuments();

        if (requiredDocuments.isNotEmpty &&
            requiredDocuments.any(
              (element) =>
                  element.documento == null || element.extension == null,
            )) {
          return 'Agregue los documentos obligatorios';
        }

        return null;

      default:
        return null;
    }
  }

  void clearCache(int projectCode) async {
    _projectsCacheRepository.removeCacheByCode(projectCode);
    _filesPersistentCacheRepository.removeCacheByCode(projectCode);
  }
}
