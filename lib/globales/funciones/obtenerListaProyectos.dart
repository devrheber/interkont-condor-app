import 'dart:convert';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:http/http.dart' as http;
import 'package:appalimentacion/globales/variables.dart';

void obtenerListaProyectos()
async{
  String url ="$urlGlobalApiCondor/vista-lista";
  var body = {
    'usuario': contenidoWebService[0]['usuario']['nombreUsu']
  };
  var response = await http.post(
    url, 
    headers: {
      "Content-type": "application/json",
      'Authorization' : contenidoWebService[0]['usuario']['tokenUsu']
    },
    body: jsonEncode(body),
  );

  var respuesta = await respuestaHttp(response.statusCode);
  if(respuesta == true){
    contenidoWebService[0]['proyectos'] = jsonDecode(response.body);

    print(contenidoWebService);
  }else{
    
  }
}