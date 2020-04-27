import 'dart:convert';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/contenido.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cargando.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReportarAvance extends StatefulWidget {
  
  ReportarAvance({Key key}) : super(key: key);
  
  @override
  ReportarAvanceState createState() => ReportarAvanceState();
}

class ReportarAvanceState extends State<ReportarAvance> {
// class ReportarAvance extends StatelessWidget {
  SharedPreferences prefs;
  String txtPrimerBoton = '';
  String txtSegundoBoton = '';
  var accionPrimerBoton = (){};
  var accionSegundoBoton = (){};
  int numeroPaso = 0;
  List proyectosSeleccionados = [];

  void obtenerVariablesSharedPreferences() async
  {
    prefs = await SharedPreferences.getInstance();
    proyectosSeleccionados = json.decode(prefs.getString('listProyectosSeleccionados'));
    actualizarPaso();
  }

  @override
  void initState(){
    super.initState();
    obtenerVariablesSharedPreferences();
  }

  void siguiente() async
  {
    proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] = proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso']+1;
    String stringListasProyectosSeleccionados = json.encode(proyectosSeleccionados);
    await prefs.setString('listProyectosSeleccionados', stringListasProyectosSeleccionados);
    actualizarPaso();
  }

  void anterior() async
  {
    proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] = proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso']-1;
    String stringListasProyectosSeleccionados = json.encode(proyectosSeleccionados);
    await prefs.setString('listProyectosSeleccionados', stringListasProyectosSeleccionados);
    actualizarPaso();
  }

  void actualizarPaso()
  {

    setState(() {
      numeroPaso = proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'];
      if(proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] == 1){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          Navigator.of(context).pop();
        };
        accionSegundoBoton = (){
          siguiente();
        };
      }else if(proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] == 2 || proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] == 3 || proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] == 4){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          anterior();
        };
        accionSegundoBoton = (){
          siguiente();
        };
      }else if(proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso'] == 5){
        txtPrimerBoton  = 'Cancelar';
          txtSegundoBoton = 'Finalizar';
          accionPrimerBoton = (){
            anterior();
          };
          accionSegundoBoton = (){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CargandoFinalizar()),
            );
          };
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      contenido: ContenidoReportarAvance(
        numeroPaso: numeroPaso
      ),
      bottomNavigationBar: true,
      contenidoBottom: contenidoBottom(
        context,
        true,
        false,
        false,
        "$txtPrimerBoton",
        "$txtSegundoBoton",
        accionPrimerBoton,
        accionSegundoBoton
      )
    );
  }

  
  
}