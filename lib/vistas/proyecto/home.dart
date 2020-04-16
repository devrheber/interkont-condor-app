import 'dart:convert';

import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/contenido.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Proyecto extends StatefulWidget {
  final String nombreIcono;
  Proyecto({Key key, this.nombreIcono}) : super(key: key);
  
  @override
  ProyectoState createState() => ProyectoState();
}

class ProyectoState extends State<Proyecto> {
// class Proyecto extends StatelessWidget {
  bool segundoBotonDesactivado = true;
  SharedPreferences prefs;
  void activarVariablesPreferences()
  async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefs;
    });
  }

  @override
  void initState(){
    activarVariablesPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      contenido: ContenidoProyecto(
        nombreIcono: widget.nombreIcono
      ),
      bottomNavigationBar: true,
      contenidoBottom: contenidoBottom(
        context,
        false,
        false,
        segundoBotonDesactivado,
        null,
        'Reportar Avance',
        null,
        ()async{
          if(segundoBotonDesactivado == true){
            setState(() {
              segundoBotonDesactivado = false;
            });
            await prefs.setString('estadoInformeProyecto', 'informeAprobado');
            
          }else{
            print('$posicionListaProyectosSeleccionado');
            cambiarPaginaSeleccionada();
            cambiarPagina(
              context, 
              ReportarAvance()
            );
          }
        }
      )
    );
  }

  List proyectosSeleccionados = [];
  void cambiarPaginaSeleccionada ()
  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    proyectosSeleccionados = json.decode(prefs.getString('listProyectosSeleccionados'));
    proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] = 1;
    String stringListasProyectosSeleccionados = json.encode(proyectosSeleccionados);
    await prefs.setString('listProyectosSeleccionados', stringListasProyectosSeleccionados);
  }

}