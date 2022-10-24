import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appalimentacion/constants/constants.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/respuestaHttp.dart';
import 'package:dio/dio.dart' as x;

class ProjectsImpl implements ProjectsRepository {
  final UserPreferences prefs = UserPreferences();
  final String _url = urlGlobalApiCondor;

  @override
  Future<List<Project>> getProjects() async {
    String url = "$_url/vista-lista";

    final user = User.fromJson(json.decode(prefs.userData));

    var body = {'usuario': user.username};
    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', user.token);
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();
      String cuerpoBody = await response.transform(utf8.decoder).join();

      var respuesta = await respuestaHttp(response.statusCode);
      if (respuesta == true) {
        final projects = vistaListaResponseFromJson(cuerpoBody);
        return projects;
      }
      throw '';
    } catch (error) {
      // TODO
      // conexionInternet = false;
      throw '';
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
        final messages = List<dynamic>.from(
            json.decode(json.encode(response.data['mensajes'])).map((x) => x['mensaje'])).toList();

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
