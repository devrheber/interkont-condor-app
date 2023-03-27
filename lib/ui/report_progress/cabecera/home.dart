import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'header_steps.dart';

class CardHeadReporteAvance extends StatelessWidget {
  const CardHeadReporteAvance({
    Key? key,
    required this.numeroPaso,
  }) : super(key: key);

  final int numeroPaso;

  @override
  Widget build(BuildContext context) {
    final project = context.read<ReportProgressProvider>().project;
    final cache = context.read<ReportProgressProvider>().cache;

    const String appBarTitle = 'Reportar Avance';

    return WillPopScope(
      onWillPop: () async {
        backReportProgress(numeroPaso, context, appBarTitle);
        return false;
      },
      child: Stack(
        children: <Widget>[
          customedAppBar(
            title: appBarTitle,
            onPressed: () =>
                backReportProgress(numeroPaso, context, appBarTitle),
          ),
          Container(
            width: double.infinity,
            height: 50.54,
            margin: const EdgeInsets.symmetric(vertical: 104, horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Percentage(
                    value: "Proyectado",
                    percentage: PercentajeFormat.percentaje(
                        cache.getPorcentajeValorProyectado)),
                const Expanded(child: SizedBox.shrink()),
                Percentage(
                  value: "Ejecutado",
                  percentage:
                      PercentajeFormat.percentaje(project.percentageByValue),
                ),
              ],
            ),
          ),
          HeaderSteps(pasoSeleccionado: numeroPaso),
        ],
      ),
    );
  }

  Future<void> backReportProgress(
    int step,
    BuildContext context,
    String title,
  ) async {
    if (step == 1) {
      Navigator.pop(context);
      return;
    }

    final confirm = await DialogHelper.showConfirmDialog(
      context,
      child: ConfirmDialog(
          title: 'Alerta',
          description: '¿Salir de "$title"?',
          continueButtonText: 'Salir',
          cancelButtonText: 'Regresar'),
    );

    if (confirm == null || !confirm) return;

    Navigator.pop(context);
  }
}

class Percentage extends StatelessWidget {
  const Percentage({
    Key? key,
    required this.percentage,
    required this.value,
  }) : super(key: key);

  final String percentage;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      width: 173.4,
      height: 50.54,
      child: Row(
        children: [
          const SizedBox(width: 16.72),
          Image.asset(
            'assets/img/Desglose/Demas/icn-money.png',
            width: 31.62,
            height: 31.62,
          ),
          const SizedBox(width: 5.97),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(child: SizedBox.shrink()),
              Text(
                percentage,
                style: const TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.61,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'Valor $value',
                style: const TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w300,
                  fontSize: 11.36,
                  color: Colors.white,
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
          const SizedBox(width: 16.72),
        ],
      ),
    );
  }
}
