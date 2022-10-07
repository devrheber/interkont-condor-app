import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VistaListaApi {
  Future<List<Project>> getProjects() async {
    String url = "$urlGlobalApiCondor/vista-lista";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userDataKey = '__user_data_key__';
    final data = jsonDecode(prefs.getString(userDataKey));

    String nombreUsu = data['username'];
    String tokenUsu = data['user_token'];
    print(nombreUsu);
    print(tokenUsu);

    var body = {'usuario': nombreUsu};
    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', tokenUsu);
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();
      String cuerpoBody = await response.transform(utf8.decoder).join();
      print(cuerpoBody);

      var respuesta = await respuestaHttp(response.statusCode);
      if (respuesta == true) {
        // contenidoWebService[0]['proyectos'] = jsonDecode(cuerpoBody);
        final projects = vistaListaResponseFromJson(cuerpoBody);
        return projects;
      }
      throw '';
    } catch (error) {
      conexionInternet = false;
      throw '';
    }
  }
}
