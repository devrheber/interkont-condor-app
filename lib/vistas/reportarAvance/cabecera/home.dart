import 'package:appalimentacion/globales/custemed_app_bar.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cabecera/cardHead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            cambiarPagina(context, Proyecto());
          },
        ),
        buildContainerPorcentajesRow(),
        pasos(pasoSeleccionado: widget.numeroPaso),
      ],
    );
  }

  Widget buildContainerPorcentajesRow() {
    return Container(
      width: double.infinity,
      height: 50.54.sp,
      margin: EdgeInsets.symmetric(vertical: 104.sp, horizontal: 28.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildPorcentaje(
              valor: "Proyectado",
              percentage:
                  "${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado'].round()}"),
          Expanded(child: Container()),
          buildPorcentaje(
              valor: "Ejecutado",
              percentage:
                  "${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado'].round()}"),
        ],
      ),
    );
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
          Expanded(
              flex: 1,
              child: Container(
                child: Image.asset(
                  'assets/img/Desglose/Demas/icn-money.png',
                  width: 31.62.sp,
                  height: 31.62.sp,
                ),
              )),
          SizedBox(width: 5.97.sp),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Container()),
                Text(
                  // '38%',
                  percentage + '%',
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 13.61.sp,
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
                    fontSize: 9.36.sp,
                    color: Colors.white,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          SizedBox(width: 16.72.sp),
        ],
      ),
    );
  }
}
