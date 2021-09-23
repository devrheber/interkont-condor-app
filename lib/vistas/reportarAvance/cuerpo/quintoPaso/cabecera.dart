import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:flutter/material.dart';

class CardHeadReporteAvanceQuintoPaso extends StatefulWidget {
  final int numeroPaso;
  CardHeadReporteAvanceQuintoPaso({
    Key key,
    this.numeroPaso,
  }) : super(key: key);

  @override
  CardHeadReporteAvanceQuintoPasoState createState() =>
      CardHeadReporteAvanceQuintoPasoState();
}

class CardHeadReporteAvanceQuintoPasoState
    extends State<CardHeadReporteAvanceQuintoPaso> {
  @protected
  void initState() {
    super.initState();
    calcularValorEjecutado();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
            customedAppBar(
          title: '¡Último paso!',
          last: true,
          onPressed: () {
            cambiarPagina(context, Proyecto());
          },
        ),  ],
    );
  }
}
