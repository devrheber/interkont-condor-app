import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/cambiarPasoProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/contenido.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cargando.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/index.dart';
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
  SharedPreferences prefs;
  String txtPrimerBoton = '';
  String txtSegundoBoton = '';
  var accionPrimerBoton = (){};
  var accionSegundoBoton = (){};
  int numeroPaso = 0;

  void obtenerVariablesSharedPreferences() async
  {
    prefs = await SharedPreferences.getInstance();
    actualizarPaso();
  }

  @override
  void initState(){
    super.initState();
    obtenerVariablesSharedPreferences();
  }

  void siguiente() async
  {
    cambiarPasoProyecto(
      numeroPaso+1
    );
    actualizarPaso();
  }

  void anterior() async
  {
    cambiarPasoProyecto(
      numeroPaso-1
    );
    actualizarPaso();
  }

  void actualizarPaso()
  {

    setState(() {
      numeroPaso = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'];
      if(numeroPaso == 1){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          Navigator.of(context).pop();
        };
        accionSegundoBoton = (){
          siguiente();
        };
      }else if(numeroPaso == 2){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          anterior();
        };
        accionSegundoBoton = (){
          print('Siguiente');
          cambiarPasoProyecto(
            2
          );
          cambiarPagina(
            context,
            IndexFactorAtraso()
          );
        };
      }else if(numeroPaso == 3 || numeroPaso == 4){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          anterior();
        };
        accionSegundoBoton = (){
          siguiente();
        };
      }else if(numeroPaso == 5){
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
        AppTheme.bottomPrincipal,
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