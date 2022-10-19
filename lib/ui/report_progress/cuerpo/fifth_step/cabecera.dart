import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:flutter/material.dart';

class CardHeadReporteAvanceQuintoPaso extends StatelessWidget {
  final int numeroPaso;
  const CardHeadReporteAvanceQuintoPaso({
    Key? key,
    required this.numeroPaso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
