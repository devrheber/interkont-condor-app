import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../globales/funciones/actualizarProyectos.dart';
import '../../globales/funciones/cambiarFormatoFecha.dart';
import '../../globales/funciones/obtenerDatosProyecto.dart';
import '../../globales/funciones/obtenerListaProyectos.dart';
import '../../globales/variables.dart';
import 'cardTitulo.dart';
import 'cuerpo.dart';

final titleColor = Color(0xff444444);

class ContenidoProyecto extends StatefulWidget {
  ContenidoProyecto({
    Key key,
  }) : super(key: key);

  @override
  ContenidoProyectoState createState() => ContenidoProyectoState();
}

class ContenidoProyectoState extends State<ContenidoProyecto>
    with TickerProviderStateMixin {
  int ultimaSincro;
  AnimationController _animationController;
  void activarUltimaSincronizacion() async {
    //**CUANDO EL CONTROLADOR SE ESTÁ ANIMANDO RETORNA NULL PARA QUE NO SE EJECUTE EL CÓDIGO DE ABAJO
    if (_animationController != null && _animationController.isAnimating)
      return;
    String ultimaSincroFecha = contenidoWebService[0]['proyectos']
        [posListaProySelec]['ultimaFechaSincro'];
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    setState(() {});
    _animationController.repeat();
    await obtenerListaProyectos();
    actualizarProyectos();
    var respuesta = await obtenerDatosProyecto(
        contenidoWebService[0]['proyectos'][posListaProySelec]
            ['codigoproyecto'],
        true);
    _animationController.reset();
    _animationController.stop();
    //**SE DESTRUYE EL CONTROLADOR PARA QUE SE PUEDA VOLVER A INICIAR LA ANIMACION CUANDO SE VUELVA A LLAMAR EL METODO
    _animationController.dispose();
    setState(() {});
    if (respuesta) {
      setState(() {
        ultimaSincro = 1;
        var fechaActual = DateTime.now();
        var formats = [M, " ", d, " ", yyyy, " ", H, ':', nn];
        ultimaSincroFecha =
            '${cambiarFormatoFecha(formatDate(fechaActual, formats))}';
      });
      contenidoWebService[0]['proyectos'][posListaProySelec]
          ['ultimaFechaSincro'] = ultimaSincroFecha;
      setState(() {});
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
        CardTitulo(
          animationController: _animationController,
          ultimaSincro: ultimaSincro,
          activarUltimaSincronizacion: activarUltimaSincronizacion,
        ),
        CardCuerpo(ultimaSincro: ultimaSincro),
      ],
    );
  }
}
