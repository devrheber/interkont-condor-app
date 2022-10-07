import 'dart:developer';

import 'package:appalimentacion/vistas/listaProyectos/project_detail_provider.dart';
import 'package:appalimentacion/vistas/listaProyectos/projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../globales/customed_app_bar.dart';
import '../../../globales/transicion.dart';
import '../../../globales/variables.dart';
import '../../proyecto/home.dart';
import 'cardHead.dart';

class CardHeadReporteAvance extends StatefulWidget {
  final int numeroPaso;
  CardHeadReporteAvance({
    Key key,
    this.numeroPaso,
  }) : super(key: key);

  @override
  CardHeadReporteAvanceState createState() => CardHeadReporteAvanceState();
}

class CardHeadReporteAvanceState extends State<CardHeadReporteAvance> {
// class CardHeadReporteAvance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        customedAppBar(
          title: 'Reportar Avance',
          onPressed: () {
            // cambiarPagina(context, Proyecto());
            // cambiarPagina(context, ProyectoScreen.init());
            Navigator.pop(context);
          },
        ),
        // buildContainerPorcentajesRow(),
        ProjectIndicators(),
        pasos(pasoSeleccionado: widget.numeroPaso),
      ],
    );
  }
}

class ProjectIndicators extends StatelessWidget {
  const ProjectIndicators({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailProvider = context.read<ProjectsProvider>();
    inspect(detailProvider);
    return Container(
      width: double.infinity,
      height: 50.54.sp,
      margin: EdgeInsets.symmetric(vertical: 104.sp, horizontal: 28.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Percentage(value: "Proyectado", percentage: ''
              // detailProvider.cache.porcentajeValorProyectadoSeleccionado,
              // TODO .round()
              ),
          const Expanded(child: SizedBox.shrink()),
          Percentage(
            value: "Proyectado",
            percentage:
                detailProvider.localProjects.first.asiVaPorcentaje.toString(),
            // TODO .round()
          ),
        ],
      ),
    );
  }
}

Container buildPorcentaje({String percentage, String valor}) {
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
              // '38%',
              percentage + '%',
              style: TextStyle(
                fontFamily: "montserrat",
                fontWeight: FontWeight.w700,
                fontSize: 15.61.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              'Valor ' + valor,
              style: TextStyle(
                fontFamily: "montserrat",
                fontWeight: FontWeight.w300,
                fontSize: 11.36.sp,
                color: Colors.white,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        SizedBox(width: 16.72.sp),
      ],
    ),
  );
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
