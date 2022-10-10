import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:flutter/material.dart';

class CardHeadReporteAvanceQuintoPaso extends StatelessWidget {
  final int numeroPaso;
  const CardHeadReporteAvanceQuintoPaso({
    Key key,
    this.numeroPaso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Calculate ExecutedValue
    // calcularValorEjecutado();
    return Stack(
      children: <Widget>[
        customedAppBar(
          title: '¡Último paso!',
          last: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
