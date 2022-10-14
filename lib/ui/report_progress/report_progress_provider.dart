import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ReportarAvanceProvider extends ChangeNotifier {
  ReportarAvanceProvider({
    @required this.project,
    @required this.detail,
    @required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    _cache = projectsCacheRepository.getCache();

    
    achievesAndDifficulties = _cache.qualitativesProgress ?? [];

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

  
  AspectoEvaluar aspectSelected;

  void changeAndSaveStep(int step) {
    this.cache = this._cache.copyWith(stepNumber: step);
    _projectsCacheRepository.saveProjectCache(projectCode, this._cache);

    notifyListeners();
  }

  List<Actividad> cacheActivities = [];



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

  bool registerDelayFactors() {
    // calculateExecutedValuePercentage();
    final porcentajeEsperado = _cache.porcentajeValorProyectadoSeleccionado -
        detail.limitePorcentajeAtraso;

    if (_cache.porcentajeValorEjecutado < porcentajeEsperado) {
      return true;
    } else {
      return false;
    }
  }

  void savePerformanceIndicator(String value) {
    print(value);
  }

  void saveIncomeGenerationDate(String value) {
    print(value);
  }

  void saveGeneratedReturns(String value) {
    print(value);
  }

  void saveCurrentMonthReturns(String value) {
    print(value);
  }

  void savePastDueMonthReturns(String value) {
    print(value);
  }

  double _getDoubleValue(String value) {
    String rawValue = value == '' ? '0' : value;
    rawValue = rawValue.replaceAll('\COP', '');
    rawValue = rawValue.replaceAll('.', '');
    rawValue = rawValue.replaceAll(',', '.');
    return double.parse(rawValue);
  }
}
