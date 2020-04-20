import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/listaProyectos/proyectos.dart';
import 'package:appalimentacion/vistas/login.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:appalimentacion/widgets/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaProyectos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        print('Saliiir ? :0');
        modalMensaje.modalOpcion(
          context, 
          "Estas apunto de cerrar la sessión", 
          ()async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('estadoLogin', null);
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => LoginPage()
              ),
            );
          }, 
          AppTheme.primero
        );
      },
      child: FondoHome(
        contenido: ProyectosContenido(),
        bottomNavigationBar: true,
        contenidoBottom: null
      )
    );
  }
}