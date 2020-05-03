
import 'dart:convert';

import 'package:appalimentacion/globales/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

void cambiarPasoProyecto(int numeroPaso)
async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'] = numeroPaso;
  prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));

}