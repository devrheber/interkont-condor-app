import 'dart:convert';
import 'dart:io';
import 'package:appalimentacion/constants/api_routes.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/helpers/respuestaHttp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
    @required String codigoProyecto,
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

    HttpClientRequest request =
        await client.getUrl(Uri.parse(_url + ApiRoutes.tiposDocumento));
    String authorization = user.token;
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', '$authorization');
    HttpClientResponse response = await request.close();

    try {
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

      Dio dio = Dio();
      var response = await dio.get(_url + ApiRoutes.tiposDocumento,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': '$authorization'
          }));
      if (response.statusCode == 200) {
        return tipoDocFromJson(json.encode(response.data));
      }
      return [];
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }
}
