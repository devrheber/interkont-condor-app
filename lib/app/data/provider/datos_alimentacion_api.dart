import 'dart:convert';
import 'dart:io';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatosAlimentacionApi {
  Future<DatosAlimentacion> obtenerDatosProyecto({
    @required String codigoProyecto,
    bool actualizarCache = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "$urlGlobalApiCondor/datos-alimentacion";

    String userDataKey = '__user_data_key__';

    final data = jsonDecode(prefs.getString(userDataKey));
    final String token = data['user_token'];

    var body = {"codigoProyecto": codigoProyecto};

    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', token);

      request.add(utf8.encode(json.encode(body)));

      HttpClientResponse response = await request.close();
      String cuerpoBody = await response.transform(utf8.decoder).join();
      print(cuerpoBody);

      var respuesta = await respuestaHttp(response.statusCode);
      if (respuesta == true) {
        final dataDecoded = jsonDecode(cuerpoBody);
        return datosAlimentacionFromJson(cuerpoBody);

        // TODO
        // actualizarPasosProyecto();
        // if (actualizarCache == true) {
        // } else {
        //   await prefs.setString(
        //       'contenidoWebService', jsonEncode(contenidoWebService));
        // }
      } else {}
      return respuesta;
    } catch (value) {
      print('Error al obtener los detalles del Proyecto');
      throw 'Error';
    }
  }
}
