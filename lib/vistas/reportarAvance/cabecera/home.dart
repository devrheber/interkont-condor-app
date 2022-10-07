import 'package:appalimentacion/vistas/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/vistas/reportarAvance/reportar_avance_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../globales/customed_app_bar.dart';
import 'cardHead.dart';

class CardHeadReporteAvance extends StatelessWidget {
  final int numeroPaso;
  CardHeadReporteAvance({
    Key key,
    this.numeroPaso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        customedAppBar(
          title: 'Reportar Avance',
          onPressed: () => Navigator.pop(context),
        ),
        ProjectIndicators(),
        pasos(pasoSeleccionado: numeroPaso),
      ],
    );
  }
}

class ProjectIndicators extends StatelessWidget {
  const ProjectIndicators({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final projectsProvider = context.read<ProjectsProvider>();
    final avancesProvider = context.read<ReportarAvanceProvider>();
    final project = avancesProvider.project;

    return Container(
      width: double.infinity,
      height: 50.54.sp,
      margin: EdgeInsets.symmetric(vertical: 104.sp, horizontal: 28.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Percentage(
            value: "Proyectado",
            percentage: projectsProvider
                .cache[avancesProvider.project.codigoproyecto.toString()]
                .porcentajeValorProyectadoSeleccionado
                .toString(),
            // TODO .round()
          ),
          const Expanded(child: SizedBox.shrink()),
          Percentage(
              value: "Proyectado",
              percentage: project.asiVaPorcentaje.toString()

              // TODO .round()
              ),
        ],
      ),
    );
  }
}

class Percentage extends StatelessWidget {
  const Percentage({
    Key key,
    @required this.percentage,
    @required this.value,
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
      width: 173.4.w,
      height: 50.54.h,
      child: Row(
        children: [
          SizedBox(width: 16.72.sp),
          Container(
            child: Image.asset(
              'assets/img/Desglose/Demas/icn-money.png',
              width: 31.62.sp,
              height: 31.62.sp,
            ),
          ),
          SizedBox(width: 5.97.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: Container()),
              Text(
                '$percentage %',
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.61.sp,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'Valor $value',
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w300,
                  fontSize: 11.36.sp,
                  color: Colors.white,
                ),
              ),
              Expanded(child: SizedBox.shrink()),
            ],
          ),
          SizedBox(width: 16.72.sp),
        ],
      ),
    );
  }
}
