import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/helpers/remote_config_service.dart';
import 'package:dio/dio.dart' as x;

import '../../constants/constants.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/projects_repository.dart';
import '../local/user_preferences.dart';

class ProjectsImpl implements ProjectsRepository {
  final UserPreferences prefs = UserPreferences();
  final RemoteConfigService remoteConfig = RemoteConfigService();
  final String _url = urlGlobalApiCondor;

  x.CancelToken? _cancelToken;

  Exception manageDioError(x.DioError e) {
    switch (e.type) {
      case x.DioErrorType.connectTimeout:
        throw const OtherException(
          'No se pudo conectar con el servidor',
        );
      case x.DioErrorType.response:
        if (e.response?.statusCode == 500) {
          final message = e.response?.data['message'] ??
              e.response?.data['data']['message'] ??
              e.response?.data;
          'Error desconocido';

          throw OtherException(message);
        }
        if (e.response?.statusCode == 403) {
          throw const OtherException(
            'No tiene permisos para realizar esta acción',
          );
        }
        throw const OtherException(
            'Algo salió mal, por favor intente nuevamente');
      case x.DioErrorType.cancel:
        throw const OtherException('Cancelado');
      case x.DioErrorType.sendTimeout:
      case x.DioErrorType.receiveTimeout:
      case x.DioErrorType.other:
        throw const OtherException('Algo salió mal');
      default:
        throw const OtherException('Error desconocido');
    }
  }

  @override
  Future<List<Project>> getAlimentacionProjects() async {
    try {
      int alimentacionProjectState =
          remoteConfig.getInt('feature_estado_obra_alimentacion');

      _cancelToken = x.CancelToken();

      final list = await getVistaLista(_cancelToken);

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

      _cancelToken = x.CancelToken();

      final list = await getVistaLista(_cancelToken);

      return list
          .where(
            (project) => project.estadoobra == aomProjectState,
          )
          .toList();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    } catch (e) {
      throw const OtherException('Error desconocido');
    }
  }

  // GetProjects
  Future<List<Project>> getVistaLista(x.CancelToken? cancelToken) async {
    final user = User.fromJson(json.decode(prefs.userData));

    Map<String, dynamic> body = {'usuario': user.username};

    x.Dio dio = x.Dio();
    dio.options = x.BaseOptions(
      baseUrl: _url,
      connectTimeout: 3500,
      headers: {
        'content-type': 'application/json',
        'Authorization': user.token,
      },
    );

    try {
      final x.Response<dynamic> response = await dio.post(
        ApiRoutes.vistaListaConsulta,
        data: body,
        cancelToken: cancelToken,
      );

      return vistaListaResponseFromJson(json.encode(response.data));
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

      if (response.statusCode == 200) {
        return datosAlimentacionFromJson(cuerpoBody);
      } else {}
      throw const OtherException('Error al obtener los datos de alimentación');
    } catch (value) {
      throw const OtherException('Error al obtener los detalles del Proyecto');
    }
  }

  @override
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
    } catch (e) {
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
            'Authorization': authorization
          }));
      if (response.statusCode == 200) {
        return tipoDocFromJson(json.encode(response.data));
      }
      return [];
    } on x.DioError catch (_) {
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
          throw const OtherException('Error desconocido');
      }
    } catch (_) {
      throw const OtherException('Error desconocido');
    }
  }

  @override
  void cancel() {
    _cancelToken?.cancel();
  }
}
