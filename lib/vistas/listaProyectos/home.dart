import 'package:flutter/material.dart';

import '../../widgets/home/fondoHome.dart';
import 'proyectos.dart';

class ListaProyectos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          // print('Saliiir ? :0');
          // modalMensaje.modalOpcion(
          //   context,
          //   "Estas apunto de cerrar la sessión",
          //   ()async{
          //     logout();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => LoginPage()
          //       ),
          //     );
          //   },
          //   AppTheme.primero
          // );
        },
        child: FondoHome(
            contenido: ProyectosContenido(),
            bottomNavigationBar: true,
            contenidoBottom: null,
            primeraPagina: true));
  }
}
