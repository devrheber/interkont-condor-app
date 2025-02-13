import 'package:flutter/material.dart';

import 'cabecera/home.dart';
import 'cuerpo/fifth_step/cabecera.dart';
import 'cuerpo/fifth_step/fifth_step.dart';
import 'cuerpo/first_step/first_step.dart';
import 'cuerpo/fourth_step/fourth_step.dart';
import 'cuerpo/second_step/second_step.dart';
import 'cuerpo/third_step/third_step.dart';

final titleColor = Color(0xff444444);

class ContenidoReportarAvance extends StatelessWidget {
  final int numeroPaso;

  ContenidoReportarAvance({
    Key? key,
    required this.numeroPaso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: <Widget>[
          if (numeroPaso == 1 || numeroPaso == 0) FirstStepBody.init(),
          if (numeroPaso == 2) const SecondStepBody(),
          if (numeroPaso == 3) const ThirdStep(),
          if (numeroPaso == 4) FourthStep.init(),
          if (numeroPaso >= 5) const FifthStep(),
          numeroPaso < 5
              ? CardHeadReporteAvance(
                  numeroPaso: numeroPaso,
                )
              : CardHeadReporteAvanceQuintoPaso(
                  numeroPaso: numeroPaso,
                ),
        ],
      ),
    );
  }
}
