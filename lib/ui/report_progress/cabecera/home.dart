import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/ui/lista_proyectos_page/projects_provider.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final projectsProvider = context.read<ProjectsProvider>();
    final project = context.read<ReportProgressProvider>().project;

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
            height: 50.54.sp,
            margin: EdgeInsets.symmetric(vertical: 104.sp, horizontal: 28.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<Map<String, ProjectCache>>(
                    stream: projectsProvider.cacheStream,
                    builder: (context,
                        AsyncSnapshot<Map<String, ProjectCache>> snapshot) {
                      return Percentage(
                          value: "Proyectado",
                          percentage: !snapshot.hasData
                              ? '0'
                              : PercentajeFormat.percentaje(snapshot
                                      .data![project.getProjectCode]
                                      ?.getPorcentajeValorProyectado ??
                                  0));
                    }),
                const Expanded(child: SizedBox.shrink()),
                StreamBuilder<double>(
                  initialData: 0.0,
                  stream: projectsProvider.getExecutedValuePercentage,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }

                    return Percentage(
                      value: "Ejecutado",
                      percentage: PercentajeFormat.percentaje(snapshot.data!),
                    );
                  },
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
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      width: 173.4.sp,
      height: 50.54.sp,
      child: Row(
        children: [
          SizedBox(width: 16.72.sp),
          Image.asset(
            'assets/img/Desglose/Demas/icn-money.png',
            width: 31.62.sp,
            height: 31.62.sp,
          ),
          SizedBox(width: 5.97.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(child: SizedBox.shrink()),
              Text(
                percentage,
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.61.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.0.sp),
              Text(
                'Valor $value',
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w300,
                  fontSize: 11.36.sp,
                  color: Colors.white,
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
          SizedBox(width: 16.72.sp),
        ],
      ),
    );
  }
}
