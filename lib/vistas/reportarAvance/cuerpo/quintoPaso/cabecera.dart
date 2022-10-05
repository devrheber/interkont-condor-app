import 'package:flutter/material.dart';

import '../../../../globales/customed_app_bar.dart';
import '../../../../globales/funciones/calcularValorEjecutado.dart';
import '../../../../globales/transicion.dart';
import '../../../proyecto/home.dart';

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
    // calcularValorEjecutado();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
            customedAppBar(
          title: '¡Último paso!',
          last: true,
          onPressed: () {
            cambiarPagina(context, ProyectoScreen());
          },
        ),  ],
    );
  }
}
// class CardHeadReporteAvanceQuintoPaso extends StatefulWidget {
//   final int numeroPaso;
//   CardHeadReporteAvanceQuintoPaso({
//     Key key,
//     this.numeroPaso,
//   }) : super(key: key);

//   @override
//   CardHeadReporteAvanceQuintoPasoState createState() =>
//       CardHeadReporteAvanceQuintoPasoState();
// }

// class CardHeadReporteAvanceQuintoPasoState
//     extends State<CardHeadReporteAvanceQuintoPaso> {
//   @protected
//   void initState() {
//     super.initState();
//     // calcularValorEjecutado();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//             customedAppBar(
//           title: '¡Último paso!',
//           last: true,
//           onPressed: () {
//             cambiarPagina(context, Proyecto());
//           },
//         ),  ],
//     );
//   }
// }
