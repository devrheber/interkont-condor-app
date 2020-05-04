import 'dart:convert';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:http/http.dart' as http;
import 'package:appalimentacion/globales/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

void obtenerListaProyectos()
async{
  String url ="$urlGlobalApiCondor/vista-lista";
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nombreUsu = '';
  String tokenUsu  = '';
  List contenidoWebServiceCache;
  if(prefs.getInt('estadoLogin') == 200 && prefs.getString('contenidoWebService') != null ){
    contenidoWebServiceCache = jsonDecode(prefs.getString('contenidoWebService'));
    nombreUsu = contenidoWebServiceCache[0]['usuario']['nombreUsu'];
    tokenUsu  = contenidoWebServiceCache[0]['usuario']['tokenUsu'];
    contenidoWebService = contenidoWebServiceCache;
  }else{
    nombreUsu = contenidoWebService[0]['usuario']['nombreUsu'];
    tokenUsu  = contenidoWebService[0]['usuario']['tokenUsu'];
  }

  var body = {
    'usuario': nombreUsu
  };
  try{
    var response = await http.post(
      url, 
      headers: {
        "Content-type": "application/json",
        'Authorization' : tokenUsu
      },
      body: jsonEncode(body),
    );

    var respuesta = await respuestaHttp(response.statusCode);
    if(respuesta == true){
      contenidoWebService[0]['proyectos'] = jsonDecode(response.body);
    }else{
      
    }
  }catch(error){
    print('Sin internet');
  }
  

}