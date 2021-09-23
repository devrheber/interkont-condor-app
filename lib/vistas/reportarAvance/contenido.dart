import 'package:appalimentacion/vistas/reportarAvance/cabecera/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/quintoPaso/cabecera.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/quintoPaso/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/tercerPaso/home.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class ContenidoReportarAvance extends StatefulWidget {
  final int numeroPaso;

  ContenidoReportarAvance({
    Key key,
    this.numeroPaso,
  }) : super(key: key);

  @override
  ContenidoReportarAvanceState createState() => ContenidoReportarAvanceState();
}

class ContenidoReportarAvanceState extends State<ContenidoReportarAvance> {
// class ContenidoReportarAvance extends StatelessWidget {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.numeroPaso == 1) CardCuerpoPrimerPaso(),
        if (widget.numeroPaso == 2) CardCuerpoSegundoPaso(),
        if (widget.numeroPaso == 3) CardCuerpoTercerPaso(),
        if (widget.numeroPaso == 4) CardCuerpoCuartoPaso(),
        if (widget.numeroPaso >= 5) CardCuerpoQuintoPaso(),
        widget.numeroPaso < 5
            ? CardHeadReporteAvance(
                numeroPaso: widget.numeroPaso,
              )
            : CardHeadReporteAvanceQuintoPaso(
                numeroPaso: widget.numeroPaso,
              ),
      ],
    );
  }
}
