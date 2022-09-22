import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/respuestaHttp.dart';
import '../variables.dart';
import 'actualizarProyectos.dart';

obtenerDatosProyecto(codigoProyecto, bool actualizarCache)
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url ="$urlGlobalApiCondor/datos-alimentacion";
  var body = {
    "codigoProyecto": codigoProyecto
  };
  
  
  try{
    // var response = await http.post(
    //   url,
    //   headers: {
    //     "Content-type": "application/json",
    //     'Authorization' : contenidoWebService[0]['usuario']['tokenUsu']
    //   },
    //   body: jsonEncode(body)
    // );

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.postUrl(Uri.parse(url)); 
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', contenidoWebService[0]['usuario']['tokenUsu']);
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String cuerpoBody = await response.transform(utf8.decoder).join();
    print(cuerpoBody);

    var respuesta = await respuestaHttp(response.statusCode);
    if(respuesta == true){
      contenidoWebService[0]['proyectos'][posListaProySelec]['datos'] = jsonDecode(cuerpoBody);
      if(actualizarCache == true){
        actualizarPasosProyecto();
      }else{
        await prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));
      }
      
    }else{
      
    }
    return respuesta;
  }catch(value){
    print('Sin internet datos del proyecto');
    return false;  
  }

  
}