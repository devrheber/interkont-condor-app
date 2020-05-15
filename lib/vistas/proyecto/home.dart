import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/cambiarPasoProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/contenido.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Proyecto extends StatefulWidget {
  Proyecto({Key key}) : super(key: key);
  
  @override
  ProyectoState createState() => ProyectoState();
}

class ProyectoState extends State<Proyecto> {
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
      ),
      bottomNavigationBar: true,
      contenidoBottom: contenidoBottom(
        context,
        AppTheme.bottomPrincipal,
        false,
        false,
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['pendienteAprobacion'],
        null,
        'Reportar Avance',
        null,
        (){
          if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['pendienteAprobacion'] == true){
            // setState(() {
            //   segundoBotonDesactivado = false;
            // });
            Toast.show(
              "Lo sentimos, este proyecto esta pendiente de aprobación, sincroniza una vez mas el proyecto, si cree que este ya ha sido aprobado", 
              context, 
              duration: 5, 
              gravity:  Toast.BOTTOM
            );
            
          }else if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'] == null){
            Toast.show(
              "Lo sentimos, este proyecto no tiene periodos que reportar", 
              context, 
              duration: 3, 
              gravity:  Toast.BOTTOM
            );
          }else{
            // print('Siguiente reportar');
            cambiarPasoProyecto(
              1
            );
            cambiarPagina(
              context, 
              ReportarAvance()
            );
          }
        }
      )
    );
  }
}