import 'package:flutter/material.dart';
import 'cabecera/home.dart';
import 'cuerpo/cuartoPaso/home.dart';
import 'cuerpo/primerPaso/home.dart';
import 'cuerpo/quintoPaso/cabecera.dart';
import 'cuerpo/quintoPaso/home.dart';
import 'cuerpo/segundoPaso/home.dart';
import 'cuerpo/tercerPaso/home.dart';

final titleColor = Color(0xff444444);

class ContenidoReportarAvance extends StatelessWidget {
  final int numeroPaso;

  ContenidoReportarAvance({
    Key key,
    @required this.numeroPaso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (numeroPaso == 1 || numeroPaso == 0) FirstStepBody(),
        if (numeroPaso == 2) CardCuerpoSegundoPaso(),
        if (numeroPaso == 3) CardCuerpoTercerPaso(),
        if (numeroPaso == 4) CardCuerpoCuartoPaso(),
        if (numeroPaso >= 5) CardCuerpoQuintoPaso(),
        numeroPaso < 5
            ? CardHeadReporteAvance(
                numeroPaso: numeroPaso,
              )
            : CardHeadReporteAvanceQuintoPaso(
                numeroPaso: numeroPaso,
              ),
      ],
    );
  }
}
