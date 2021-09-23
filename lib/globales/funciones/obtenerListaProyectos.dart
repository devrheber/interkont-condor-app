import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> obtenerListaProyectos() async {
  String url = "$urlGlobalApiCondor/vista-lista";
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nombreUsu = '';
  String tokenUsu = '';
  List contenidoWebServiceCache;
  if (prefs.getInt('estadoLogin') == 200 &&
      prefs.getString('contenidoWebService') != null) {
    contenidoWebServiceCache =
        jsonDecode(prefs.getString('contenidoWebService'));
    nombreUsu = contenidoWebServiceCache[0]['usuario']['nombreUsu'];
    tokenUsu = contenidoWebServiceCache[0]['usuario']['tokenUsu'];
    contenidoWebService = contenidoWebServiceCache;
  } else {
    nombreUsu = contenidoWebService[0]['usuario']['nombreUsu'];
    tokenUsu = contenidoWebService[0]['usuario']['tokenUsu'];
  }

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
      contenidoWebService[0]['proyectos'] = jsonDecode(cuerpoBody);
    } else {}
  } catch (error) {
    print('Sin internet');
    conexionInternet = false;
  }
}
