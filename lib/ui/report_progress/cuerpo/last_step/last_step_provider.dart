import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/local/user_preferences.dart';
import '../../../../domain/models/models.dart';
import '../../../../domain/repository/cache_repository.dart';
import '../../../../domain/repository/files_persistent_cache_repository.dart';
import '../../../../domain/repository/projects_repository.dart';
import '../../../../helpers/project_helpers.dart';

enum SendDataState {
  success,
  backendError,
  noInternet,
  other,
}

class LastStepProvider extends ChangeNotifier {
  LastStepProvider({
    required ProjectsRepository projectsRepository,
    required ProjectsCacheRepository projectsCacheRepository,
    required FilesPersistentCacheRepository filesPersistentCacheRepository,
  })  : _projectsRepository = projectsRepository,
        _projectsCacheRepository = projectsCacheRepository,
        _filesPersistentCacheRepository = filesPersistentCacheRepository {
    _project = _projectsCacheRepository.getProject();
    _detail = _projectsCacheRepository.getDetail(_project.codigoproyecto)!;
    _cache = _projectsCacheRepository.getCache()!;
    mainPhoto = _filesPersistentCacheRepository.getMainPhoto()!;
    complementaryImages =
        _filesPersistentCacheRepository.getComplementaryImages();
    requiredDocuments = _filesPersistentCacheRepository.getRequiredDocuments();
    additionalDocuments =
        _filesPersistentCacheRepository.getAdditionalDocuments();
  }

  UserPreferences prefs = UserPreferences();

  late Project _project;
  late DatosAlimentacion _detail;
  late ProjectCache _cache;
  final ProjectsRepository _projectsRepository;
  final ProjectsCacheRepository _projectsCacheRepository;
  final FilesPersistentCacheRepository _filesPersistentCacheRepository;
  late String username;
  late String userToken;

  AlimentacionRequest? data;

  late ComplementaryImage mainPhoto;
  List<ComplementaryImage> complementaryImages = [];
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];

  final uploadPercentage = PublishSubject<double>();

  int get projectCode => _project.codigoproyecto;

  void guardarAlimentacion() {
    final user = User.fromJson(json.decode(prefs.userData));

    List<ActividadRequest> actividades = [];
    List<IndicadoresAlcanceRequest> indicadoresDeAlcance = [];
    List<AspectoEvaluarRequest> aspectosEvaluar = [];
    List<DocumentoRequest> documentosObligatorios = [];
    List<DocumentoRequest> documentosOpcionales = [];
    List<FactoresAtrasoRequest> factoresAtraso = [];
    FotoPrincipalRequest fotoPrincipal = FotoPrincipalRequest(
      image: mainPhoto.imageString!,
      // nombre: mainPhoto.name,
      nombre: 'fotoPrincipal',
      tipo: mainPhoto.type,
    );
    List<FotoPrincipalRequest> imagenesComplementarias = [];

    for (final item in _detail.actividades) {
      final newActivity = ActividadRequest(
        actividadId: item.actividadId,
        cantidadEjecutada: _cache.activitiesProgress == null
            ? 0
            : _cache.activitiesProgress!.containsKey(item.getStringId)
                ? item.getNewExecutedValue(
                    double.tryParse(
                            _cache.activitiesProgress?[item.getStringId]) ??
                        0.0,
                  )
                : 0,
      );
      actividades.add(newActivity);
    }

    for (final item in _detail.indicadoresAlcance) {
      final element = IndicadoresAlcanceRequest(
          cantidadEjecucion: item.indicadorAlcanceId,
          indicadorAlcanceId: _cache.rangeIndicators == null
              ? 0
              : _cache.rangeIndicators!.containsKey(item.getId)
                  ? int.tryParse(_cache.rangeIndicators?[
                          item.indicadorAlcanceId.toString()]) ??
                      0
                  : 0);
      indicadoresDeAlcance.add(element);
    }

    for (final item in _cache.qualitativesProgress ?? []) {
      final newItem = AspectoEvaluarRequest(
        aspectoEvaluarId: item.aspectToEvaluateId,
        dificultadesAspectoEvaluar: item.difficulty,
        logrosAspectoEvaluar: item.achive,
      );
      aspectosEvaluar.add(newItem);
    }

    for (final item in requiredDocuments) {
      final newDocument = DocumentoRequest(
          documento: item.documento!,
          extension: item.extension!,
          nombre: item.nombre!,
          tipoId: item.tipoId);

      documentosObligatorios.add(newDocument);
    }

    for (final item in additionalDocuments) {
      final newDocument = DocumentoRequest(
          documento: item.documento!,
          extension: item.extension!,
          nombre: item.nombre!,
          tipoId: item.tipoId);

      documentosOpcionales.add(newDocument);
    }

    for (final item in _cache.delayFactors ?? []) {
      final newDelayFactor = FactoresAtrasoRequest(
        factorAtrasoId: item.factorAtrasoId,
        descripcion: item.description,
      );

      factoresAtraso.add(newDelayFactor);
    }

    for (final item in complementaryImages) {
      final newImage = FotoPrincipalRequest(
        image: item.imageString!,
        nombre: item.name,
        tipo: item.type,
      );

      imagenesComplementarias.add(newImage);
    }

    data = AlimentacionRequest(
      actividades: actividades,
      aspectosEvaluar: aspectosEvaluar,
      codigoproyecto: _project.codigoproyecto,
      descripcion: _cache.comment!,
      documentosObligatorios: documentosObligatorios,
      documentosOpcionales: documentosOpcionales,
      factoresAtraso: factoresAtraso,
      fechaGeneracionRendimientos: _cache.incomeGenerationDate,
      fechaReintegroRendimientos: _cache.rentalRepaymentDate,
      fotoPrincipal: fotoPrincipal,
      imagenesComplementarias: imagenesComplementarias,
      indicadoresAlcance: indicadoresDeAlcance,
      periodoId: _cache.periodoIdSeleccionado!,
      usuario: user.username,
      valorRendimientosGenerados:
          ProjectHelpers.getDoubleValue(_cache.generatedReturns),
      valorReintegroRendimientos:
          ProjectHelpers.getDoubleValue(_cache.valorReintegroRendimientos),
      valorSaldoFinalExtracto:
          ProjectHelpers.getDoubleValue(_cache.valorSaldoFinalExtracto),
    );

    inspect(data!.toJson());
  }

  void _onSendProgress(int count, int total) {
    uploadPercentage.add(count / total);
  }

  void _onReceiveProgress(int count, int total) {
    // TODO
  }

  Future<Map<String, dynamic>> sendData() async {
    try {
      final result = await _projectsRepository.sendData(data!,
          onSendProgress: _onSendProgress,
          onReceiveProgress: _onReceiveProgress);

      if (result['success'] as bool && result['status'] == 0) {
        _projectsCacheRepository.saveProjectCache(
          projectCode,
          _cache.copyWith(
            porPublicar: false,
            stepNumber: 0,
          ),
        );
        return {
          'success': true,
          'message': '',
          'state': SendDataState.success,
        };
      }

      if (result['status'] == 1) {
        print(result['messages']);
        inspect(result['messages']);

        return {
          'success': true,
          'message': result['messages'].first,
          'state': SendDataState.backendError,
        };
      }
    } on ProjectsRepositoryException catch (error) {
      if (error is NoInternetException) {
        return {
          'success': false,
          'message': 'No tiene conección a internet',
          'state': SendDataState.noInternet,
        };
      }

      _projectsCacheRepository.saveProjectCache(
        projectCode,
        _cache.copyWith(
          porPublicar: true,
          stepNumber: 5,
        ),
      );
    } catch (_) {
      return {
        'success': false,
        'message': 'Error desconocido',
        'state': SendDataState.other
      };
    }

    return {
      'success': false,
      'message': 'Error desconocido',
      'state': SendDataState.other
    };
  }

  void saveDataPendingToPublish() {
    _projectsCacheRepository.saveCache(
      this._cache.copyWith(
            porPublicar: true,
            stepNumber: 5,
          ),
    );
  }
}
