import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:appalimentacion/helpers/remote_config_service.dart';
import 'package:dio/dio.dart' as x;

import '../../constants/constants.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/projects_repository.dart';
import '../../helpers/respuestaHttp.dart';
import '../local/user_preferences.dart';

class ProjectsImpl implements ProjectsRepository {
  final UserPreferences prefs = UserPreferences();
  final RemoteConfigService remoteConfig = RemoteConfigService();
  final String _url = urlGlobalApiCondor;

  Exception manageDioError(x.DioError e) {
    switch (e.type) {
      case x.DioErrorType.connectTimeout:
        throw AomProjectsSlowConnectionException();
      case x.DioErrorType.response:
        if (e.response?.statusCode == 500) {
          throw AomProjectsBackendErrorException(e.response?.data);
        }
        if (e.response?.statusCode == 403) {
          throw AomProjectsForbiddenException();
        }
        throw AomProjectsOtherEception();
      case x.DioErrorType.cancel:
        throw AomProjectsCancelException();
      case x.DioErrorType.sendTimeout:
      case x.DioErrorType.receiveTimeout:
      case x.DioErrorType.other:
        throw AomProjectsOtherEception();
      default:
        throw AomProjectsOtherEception();
    }
  }

  @override
  Future<List<Project>> getAlimentacionProjects() async {
    try {
      int alimentacionProjectState =
          remoteConfig.getInt('feature_estado_obra_alimentacion');

      final list = await getVistaLista();

      return list
          .where(
            (project) => project.estadoobra == alimentacionProjectState,
          )
          .toList();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<List<Project>> getAomProjects() async {
    try {
      int aomProjectState = remoteConfig.getInt('feature_estado_obra_aom');

      final list = await getVistaLista();

      return list
          .where(
            (project) => project.estadoobra == aomProjectState,
          )
          .toList();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  // GetProjects
  Future<List<Project>> getVistaLista() async {
    final user = User.fromJson(json.decode(prefs.userData));

    Map<String, dynamic> body = {'usuario': user.username};

    x.Dio dio = x.Dio();
    dio.options = x.BaseOptions(baseUrl: _url, connectTimeout: 3500, headers: {
      'content-type': 'application/json',
      'Authorization': user.token,
    });

    try {
      final x.Response<dynamic> response = await dio.post(
        ApiRoutes.vistaListaConsulta,
        data: body,
      );

      if (response.statusCode == 200) {
        return vistaListaResponseFromJson(json.encode(response.data));
      }

      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DatosAlimentacion> getDatosAlimentacion({
    required String codigoProyecto,
  }) async {
    String url = "$_url/datos-alimentacion";

    final user = User.fromJson(json.decode(prefs.userData));

    var body = {"codigoProyecto": codigoProyecto};

    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', user.token);

      request.add(utf8.encode(json.encode(body)));

      HttpClientResponse response = await request.close();
      String cuerpoBody = await response.transform(utf8.decoder).join();
      print(cuerpoBody);

      var respuesta = await respuestaHttp(response.statusCode);
      if (respuesta == true) {
        return datosAlimentacionFromJson(cuerpoBody);
      } else {}
      throw '';
    } catch (value) {
      print('Error al obtener los detalles del Proyecto');
      // TODO
      rethrow;
    }
  }

  Future<List<TipoDoc>> getTipoDoc() async {
    HttpClient client = HttpClient();

    final user = User.fromJson(json.decode(prefs.userData));

    try {
      HttpClientRequest request =
          await client.getUrl(Uri.parse(_url + ApiRoutes.tiposDocumento));
      String authorization = user.token;
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', '$authorization');
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        return tipoDocFromJson(responseBody);
      }
      return [];
    } on Error catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TipoDoc>> getTipoDocWithDio() async {
    try {
      final user = User.fromJson(json.decode(prefs.userData));
      String authorization = user.token;

      x.Dio dio = x.Dio();
      var response = await dio.get(_url + ApiRoutes.tiposDocumento,
          options: x.Options(headers: {
            'content-type': 'application/json',
            'Authorization': '$authorization'
          }));
      if (response.statusCode == 200) {
        return tipoDocFromJson(json.encode(response.data));
      }
      return [];
    } on x.DioError catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> sendData(AlimentacionRequest data,
      {required onSendProgress(int count, int total),
      required onReceiveProgress(int count, int total)}) async {
    x.Dio dio = x.Dio();
    dio.options = x.BaseOptions(
      connectTimeout: 3500,
    );

    String url = "$_url/guardar-alimentacion";
    final user = User.fromJson(json.decode(prefs.userData));
    try {
      final x.Response<dynamic> response = await dio.post(
        url,
        options: x.Options(
          headers: {
            "Content-type": "application/json",
            'Authorization': user.token
          },
        ),
        data: data.toJson(),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      inspect(response);
      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final messages = List<dynamic>.from(json
            .decode(json.encode(response.data['mensajes']))
            .map((x) => x['mensaje'])).toList();

        return {
          'success': true,
          'status': response.data['status'],
          // 'messages': response.data['mensajes'],
          'messages': messages.isEmpty
              ? 'Ocurrió un error al grabar la información'
              : messages
        };
      } else {
        return {
          'success': false,
        };
      }
    } on x.DioError catch (error) {
      inspect(error);
      print(error);
      switch (error.type) {
        case x.DioErrorType.connectTimeout:
          throw SlowConnectionException();
        case x.DioErrorType.response:
          throw ResponseException();
        case x.DioErrorType.other:
          throw NoInternetException();
        case x.DioErrorType.sendTimeout:
        case x.DioErrorType.receiveTimeout:
        case x.DioErrorType.cancel:
          throw OtherException('Error desconocido');
      }
    } catch (_) {
      inspect(_);
      print(_);
      throw OtherException('Error desconocido');
    }
  }
}
