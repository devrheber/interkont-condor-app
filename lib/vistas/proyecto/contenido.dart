import 'package:appalimentacion/globales/funciones/actualizarProyectos.dart';
import 'package:appalimentacion/globales/funciones/cambiarFormatoFecha.dart';
import 'package:appalimentacion/globales/funciones/obtenerDatosProyecto.dart';
import 'package:appalimentacion/globales/funciones/obtenerListaProyectos.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/cardTitulo.dart';
import 'package:appalimentacion/vistas/proyecto/cuerpo.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

final titleColor = Color(0xff444444);

class ContenidoProyecto extends StatefulWidget {
  final actualizarEstadoHome;
  ContenidoProyecto({Key key, this.actualizarEstadoHome}) : super(key: key);

  @override
  ContenidoProyectoState createState() => ContenidoProyectoState();
}

class ContenidoProyectoState extends State<ContenidoProyecto> {
  int ultimaSincro;

  activarUltimaSincronizacion() async {
    await obtenerListaProyectos();
    await actualizarProyectos();
    var respuesta = await obtenerDatosProyecto(
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['codigoproyecto'],
        true);
    if (respuesta) {
      setState(() {
        ultimaSincro = 1;
        var fechaActual = DateTime.now();
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['ultimaFechaSincro'] =
            '${cambiarFormatoFecha(formatDate(fechaActual, [
          M,
          " ",
          d,
          " ",
          yyyy,
          " ",
          H,
          ':',
          nn
        ]))}';
      });
      widget.actualizarEstadoHome();
      Toast.show("Proyecto sincronizado correctamente!", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show(
          "Lo sentimos, debe estar conectado a internet para sincronizar el proyecto",
          context,
          duration: 3,
          gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardCuerpo(ultimaSincro: ultimaSincro),
        CardTitulo(
          ultimaSincro: ultimaSincro,
          activarUltimaSincronizacion: activarUltimaSincronizacion,
        ),
      ],
    );
  }
}
