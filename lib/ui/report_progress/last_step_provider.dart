import 'dart:convert';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LastStepProvider extends ChangeNotifier {
  LastStepProvider({
    Project project,
    DatosAlimentacion detail,
    ProjectCache cache,
    ProjectsCacheRepository projectsCacheRepository,
  })  : _project = project,
        _detail = detail,
        _cache = cache,
        _projectsCacheRepository = projectsCacheRepository {
    guardarAlimentacion();
  }

  final Project _project;
  final DatosAlimentacion _detail;
  final ProjectCache _cache;
  final ProjectsCacheRepository _projectsCacheRepository;
  String username;
  String userToken;

  int get projectCode => _project.codigoproyecto;

  Future<Map<String, dynamic>> guardarAlimentacion() async {
    String url = "$urlGlobalApiCondor/guardar-alimentacion";
    List actividades = [];
    List avancesCualitativos = [];
    List factoresAtraso = [];
    List indicadoresAlcance = [];

    if (_detail.actividades != null) {
      for (int i = 0; i < _detail.actividades.length; i++) {
        double cantidadEjecutada;
        if (_cache.activitiesProgress[
                _detail.actividades[i].actividadId.toString()] !=
            null) {
          cantidadEjecutada = double.parse(
              '${_cache.activitiesProgress[_detail.actividades[i].actividadId.toString()]}');
        } else {
          cantidadEjecutada = 0.0;
        }
        var listaArmada = {
          'actividadId': int.parse('${_detail.actividades[i].actividadId}'),
          'cantidadEjecutada': cantidadEjecutada
        };
        actividades.add(listaArmada);
      }
    }

    if (_cache.qualitativesProgress != null) {
      for (int i = 0; i < _cache.qualitativesProgress.length; i++) {
        String dificultad;
        if (_cache.qualitativesProgress[i].difficulty == null ||
            _cache.qualitativesProgress[i].difficulty == '') {
          dificultad = '';
        } else {
          dificultad = '${_cache.qualitativesProgress[i].difficulty}';
        }

        String logros;
        if (_cache.qualitativesProgress[i].achive == null ||
            _cache.qualitativesProgress[i].achive == '') {
          logros = '';
        } else {
          logros = _cache.qualitativesProgress[i].achive;
        }

        var listaArmada = {
          'aspectoEvaluarId': _cache.qualitativesProgress[i].aspectToEvaluateId,
          'dificultadesAspectoEvaluar': dificultad,
          'logrosAspectoEvaluar': logros,
        };

        avancesCualitativos.add(listaArmada);
      }
    }

    if (_cache.delayFactors !=
        // ['factoresAtrasoSeleccionados'] !=
        null) {
      for (int i = 0; i < _cache.delayFactors.length; i++) {
        factoresAtraso
            .add({'factorAtrasoId': _cache.delayFactors[i].factorAtrasoId});
      }
    }

    if (_detail.indicadoresAlcance != null) {
      for (int i = 0; i < _detail.indicadoresAlcance.length; i++) {
        double cantidadEjecucion;
        if (_detail.indicadoresAlcance[i]['txtEjecucionIndicadorAlcance'] ==
                null ||
            _detail.indicadoresAlcance[i]['txtEjecucionIndicadorAlcance'] ==
                '') {
          cantidadEjecucion = 0.0;
        } else {
          cantidadEjecucion = double.parse(
              '${_detail.indicadoresAlcance[i]['txtEjecucionIndicadorAlcance']}');
        }
        var listaArmada = {
          'indicadorAlcanceId': _detail.indicadoresAlcance[i]
              ['indicadorAlcanceId'],
          'cantidadEjecucion': cantidadEjecucion,
        };
        indicadoresAlcance.add(listaArmada);
      }
    }

    print(indicadoresAlcance);

    var body = {
      "actividades": actividades,
      "aspectosEvaluar": avancesCualitativos,
      "codigoproyecto": _project.codigoproyecto,
      "descripcion": _cache.comment,
      "factoresAtraso": factoresAtraso,
      "fotoPrincipal": {
        "image": _cache.fileFotoPrincipal,
        "nombre": "fotoPrincipal",
        "tipo": "jpeg"
      },
      // TODO ['filesFotosComplementarias']
      "imagenesComplementarias": '_cache.complementaryImages',
      "indicadoresAlcance": indicadoresAlcance,
      "periodoId": _cache.periodoIdSeleccionado,
      "usuario": username,
    };

    String tokenUsu = userToken;

    try {
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          'Authorization': tokenUsu
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
