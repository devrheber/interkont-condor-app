import 'dart:convert';
import 'dart:developer';

import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/alimentacion_request.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LastStepProvider extends ChangeNotifier {
  LastStepProvider({
    @required ProjectsCacheRepository projectsCacheRepository,
    @required FilesPersistentCacheRepository filesPersistentCacheRepository,
  })  : _projectsCacheRepository = projectsCacheRepository,
        _filesPersistentCacheRepository = filesPersistentCacheRepository {
    _project = _projectsCacheRepository.getProject();
    _detail = _projectsCacheRepository.getDetail(_project.codigoproyecto);
    _cache = _projectsCacheRepository.getCache();
    mainPhoto = _filesPersistentCacheRepository.getMainPhoto();
    complementaryImages =
        _filesPersistentCacheRepository.getComplementaryImages();
    requiredDocuments = _filesPersistentCacheRepository.getRequiredDocuments();
    additionalDocuments =
        _filesPersistentCacheRepository.getAdditionalDocuments();
    guardarAlimentacion();
  }

  UserPreferences prefs = UserPreferences();

  Project _project;
  DatosAlimentacion _detail;
  ProjectCache _cache;
  final ProjectsCacheRepository _projectsCacheRepository;
  final FilesPersistentCacheRepository _filesPersistentCacheRepository;
  String username;
  String userToken;

  ComplementaryImage mainPhoto;
  List<ComplementaryImage> complementaryImages = [];
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];

  int get projectCode => _project.codigoproyecto;

  double _getDoubleValue(String value) {
    String rawValue = value == '' ? '0' : value;
    rawValue = rawValue.replaceAll('\COP', '');
    rawValue = rawValue.replaceAll('.', '');
    rawValue = rawValue.replaceAll(',', '.');
    return double.parse(rawValue);
  }

  Future<Map<String, dynamic>> guardarAlimentacion() async {
    String url = "$urlGlobalApiCondor/guardar-alimentacion";

    final user = User.fromJson(json.decode(prefs.userData));

    List<ActividadRequest> actividades = [];
    List<AspectoEvaluarRequest> aspectosEvaluar = [];
    List<DocumentoRequest> documentosObligatorios = [];
    List<DocumentoRequest> documentosOpcionales = [];
    List<FactoresAtrasoRequest> factoresAtraso = [];
    FotoPrincipalRequest fotoPrincipal = FotoPrincipalRequest(
      image: mainPhoto.imageString,
      nombre: mainPhoto.name,
      tipo: mainPhoto.type,
    );
    List<FotoPrincipalRequest> imagenesComplementarias = [];

    for (final item in _detail.actividades) {
      final newActivity = ActividadRequest(
        actividadId: item.actividadId,
        cantidadEjecutada: _cache.activitiesProgress == null
            ? 0
            : item.getNewExecutedValue(
                double.tryParse(
                    _cache.activitiesProgress[item.actividadId.toString()] ??
                        '0'),
              ),
      );
      actividades.add(newActivity);
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
          documento: item.documento,
          extension: item.extension,
          nombre: item.nombre,
          tipoId: item.tipoId);

      documentosObligatorios.add(newDocument);
    }

    for (final item in additionalDocuments) {
      final newDocument = DocumentoRequest(
          documento: item.documento,
          extension: item.extension,
          nombre: item.nombre,
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
        image: item.imageString,
        nombre: item.name,
        tipo: item.type,
      );

      imagenesComplementarias.add(newImage);
    }

    final data = AlimentacionRequest(
      actividades: actividades,
      aspectosEvaluar: aspectosEvaluar,
      codigoproyecto: _project.codigoproyecto,
      descripcion: _cache.comment,
      documentosObligatorios: documentosObligatorios,
      documentosOpcionales: documentosOpcionales,
      factoresAtraso: factoresAtraso,
      fechaGeneracionRendimientos: _cache.incomeGenerationDate,
      fechaReintegroRendimientos: _cache.rentalRepaymentDate,
      fotoPrincipal: fotoPrincipal,
      imagenesComplementarias: imagenesComplementarias,
      indicadoresAlcance: [],
      periodoId: _cache.periodoIdSeleccionado,
      usuario: user.username,
      valorRendimientosGenerados: _getDoubleValue(_cache.generatedReturns),
      valorRendimientosMesActual: _getDoubleValue(_cache.currentMonthReturns),
      valorRendimientosMesVencido: _getDoubleValue(_cache.pastDueMonthReturns),
    );

    // inspect(data.toJson());

    try {
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: jsonEncode(data.toJson()),
        headers: {
          "Content-type": "application/json",
          'Authorization': user.token
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _projectsCacheRepository.saveProjectCache(
          projectCode,
          _cache.copyWith(
            porPublicar: false,
            stepNumber: 0,
          ),
        );

        _projectsCacheRepository.clearData();
        _filesPersistentCacheRepository.clearData();

        return {
          'success': true,
          'correcto': true,
          'message': true,
        };

        // TODO
        // await obtenerListaProyectos();
        // await actualizarProyectos();
        // await obtenerDatosProyecto(project.codigoproyecto, false);
        // if (pasaron10Segundos == true) {

      } else {
        _projectsCacheRepository.saveProjectCache(
          projectCode,
          _cache.copyWith(
            porPublicar: true,
            stepNumber: 5,
          ),
        );

        return {
          'success': false,
          'message': '',
        };
      }
    } catch (erro) {
      _projectsCacheRepository.saveProjectCache(
        projectCode,
        _cache.copyWith(
          porPublicar: true,
          stepNumber: 5,
        ),
      );

      return {
        'success': false,
        'message': '',
      };
    }
  }
}
