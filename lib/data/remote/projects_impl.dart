import 'dart:convert';
import 'dart:io';
import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:flutter/foundation.dart';

class ProjectsImpl implements ProjectsRepository {
  final UserPreferences prefs = UserPreferences();

  @override
  Future<List<Project>> getProjects() async {
    String url = "$urlGlobalApiCondor/vista-lista";

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
    String url = "$urlGlobalApiCondor/datos-alimentacion";

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
}
