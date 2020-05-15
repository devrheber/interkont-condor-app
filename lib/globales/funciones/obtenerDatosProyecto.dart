import 'dart:convert';
import 'package:appalimentacion/globales/funciones/actualizarProyectos.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:http/http.dart' as http;
import 'package:appalimentacion/globales/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

obtenerDatosProyecto(codigoProyecto)
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url ="$urlGlobalApiCondor/datos-alimentacion";
  var body = {
    "codigoProyecto": codigoProyecto
  };
  
  
  try{
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization' : contenidoWebService[0]['usuario']['tokenUsu']
      },
      body: jsonEncode(body)
    );
    var respuesta = await respuestaHttp(response.statusCode);
    if(respuesta == true){
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos'] = jsonDecode(response.body);
      // await prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));
      actualizarPasosProyecto();
    }else{
      
    }
    return respuesta;
  }catch(value){
    print('Sin internet datos del proyecto');
    return false;  
  }

  
}