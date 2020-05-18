import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/cambiarPasoProyecto.dart';
import 'package:appalimentacion/globales/funciones/obtenerDatosProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/contenido.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cargando.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/index.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class ReportarAvance extends StatefulWidget {
  
  ReportarAvance({Key key}) : super(key: key);
  
  @override
  ReportarAvanceState createState() => ReportarAvanceState();
}

class ReportarAvanceState extends State<ReportarAvance> {
  SharedPreferences prefs;
  String txtPrimerBoton = '';
  String txtSegundoBoton = '';
  var accionPrimerBoton  = (){};
  var accionSegundoBoton = (){};
  int numeroPaso = 0;
  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  
  void obtenerVariablesSharedPreferences() async
  {
    prefs = await SharedPreferences.getInstance();
    actualizarPaso(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso']);
    print(numeroPaso);
  }

  @override
  void initState(){
    // print(numeroPaso);
    super.initState();
    obtenerVariablesSharedPreferences();
    if(keyboardVisibilitySubscriberId3 == null){
      print('escuchar teclado ');
      keyboardVisibilitySubscriberId3 = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          if(numeroPaso == 4 || numeroPaso == 1 ){
            if(visible == false){
              print('$visible');
              setState(() {
                
              });
            }
          }
        },
      );
    }else if(keyboardVisibilitySubscriberId3 != null){
      _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId3);
      keyboardVisibilitySubscriberId3 = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          if(numeroPaso == 4 || numeroPaso == 1){
            if(visible == false){
              print('$visible');
              setState(() {
                
              });
            }
          }
        },
      );
    }
  }

  @protected
  void dispose() { 
    return _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId3);
  }

  void siguiente() async
  {
    if( contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado'].round() > 100 ){
      Toast.show(
        "Lo sentimos, el valor ejecutado debe estar por debajo al 100%", 
        context, 
        duration: 5, 
        gravity:  Toast.BOTTOM
      );
    }else if(bool_estSegundoBtn_reportarAvance == true && numeroPaso == 4){
      
    }else if( contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['fileFotoPrincipal'] == null && numeroPaso == 4){
      Toast.show(
        "Es necesario una foto principal", 
        context, 
        duration: 5, 
        gravity:  Toast.BOTTOM
      );
    }else{
      actualizarPaso(numeroPaso+1);
      setState(() {
        bool_estSegundoBtn_reportarAvance = false;
      });
      cambiarPasoProyecto(
        numeroPaso+1
      );
      print(numeroPaso);
      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'] == null && numeroPaso == 4){
        print('bool_estSegundoBtn_reportarAvance');
        setState(() {
          bool_estSegundoBtn_reportarAvance = true;
        });
      }else if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'] != null && numeroPaso == 4 && contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'].length < 1){
        print('bool_estSegundoBtn_reportarAvance');
        setState(() {
          bool_estSegundoBtn_reportarAvance = true;
        });
      }
    }
  }

  void anterior() async
  {
    setState(() {
      bool_estSegundoBtn_reportarAvance = false;
    });
    actualizarPaso(numeroPaso-1);
    cambiarPasoProyecto(
      numeroPaso-1
    );
  }

  void actualizarPaso(int numeroPasoActualizado)
  {

    setState(() {
      // numeroPaso = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'];
      numeroPaso = numeroPasoActualizado;
      if(numeroPaso == 1){
        txtPrimerBoton  = 'Cancelar';
        txtSegundoBoton = 'Siguíente Paso';
        accionPrimerBoton = (){
          obtenerDatosProyecto(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['codigoproyecto'], false);
          Toast.show(
            "El proyecto ha sido cancelado", 
            context, 
            duration: 5, 
            gravity:  Toast.BOTTOM
          );
          cambiarPagina(context, ListaProyectos());
          setState(() {
            bool_estSegundoBtn_reportarAvance = false;
          });
          actualizarPaso(0);
          cambiarPasoProyecto(
            0
          );
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
          if(((contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado']/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado'])*100)-100 > contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['limitePorcentajeAtraso']){
            cambiarPasoProyecto(
              2
            );
            cambiarPagina(
              context,
              IndexFactorAtraso()
            );
          }else{
            siguiente();
          }
          // print('Siguiente');
          
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
      }else if(numeroPaso >= 5){
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
        bool_estSegundoBtn_reportarAvance,
        "$txtPrimerBoton",
        "$txtSegundoBoton",
        accionPrimerBoton,
        accionSegundoBoton
      )
    );
  }
}