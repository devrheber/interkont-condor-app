import 'package:flutter/material.dart';
import 'cabecera/home.dart';
import 'cuerpo/cuartoPaso/home.dart';
import 'cuerpo/primerPaso/home.dart';
import 'cuerpo/quintoPaso/cabecera.dart';
import 'cuerpo/quintoPaso/home.dart';
import 'cuerpo/segundoPaso/home.dart';
import 'cuerpo/tercerPaso/home.dart';

final titleColor = Color(0xff444444);

class ContenidoReportarAvance extends StatefulWidget {
  final int numeroPaso;

  ContenidoReportarAvance({
    Key key,
    @required this.numeroPaso,
  }) : super(key: key);

  @override
  ContenidoReportarAvanceState createState() => ContenidoReportarAvanceState();
}

class ContenidoReportarAvanceState extends State<ContenidoReportarAvance> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Stack(
      children: <Widget>[
        // if (widget.numeroPaso == 1) CardCuerpoPrimerPaso(),
        if (widget.numeroPaso == 1)
          FirstStepBody(activities: []
              // TODO
              //  provider
              //     .projectDetails[provider.codeProjectSelected.toString()]
              //     .actividades
              ),
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
