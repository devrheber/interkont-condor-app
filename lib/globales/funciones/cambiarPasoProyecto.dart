
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';

void cambiarPasoProyecto(int numeroPaso)
async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'] = numeroPaso;
  prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));

}