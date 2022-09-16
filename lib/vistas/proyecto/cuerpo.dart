import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globales/colores.dart';
import '../../globales/variables.dart';
import 'widgets/seleccionaPeriodo.dart';

class CardCuerpo extends StatefulWidget {
  final int ultimaSincro;
  CardCuerpo({Key key, this.ultimaSincro}) : super(key: key);

  @override
  CardCuerpoState createState() => CardCuerpoState();
}

class CardCuerpoState extends State<CardCuerpo> {
  SharedPreferences prefs;
  void activarVariablesPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefs;
    });
    await prefs.setString(
        'contenidoWebService', jsonEncode(contenidoWebService));
  }

  double valorejecutado = contenidoWebService[0]['proyectos']
      [posicionListaProyectosSeleccionado]['valorejecutado'];
  double valorproyecto = contenidoWebService[0]['proyectos']
      [posicionListaProyectosSeleccionado]['valorproyecto'];
  int porcentajeAsiVa = 0;

  @override
  void initState() {
    setState(() {
      porcentajeAsiVa = ((100 * valorejecutado) / valorproyecto).round();
    });
    if (contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['periodoIdSeleccionado'] !=
        null) {
      setState(() {
        periodoIdSeleccionado = contenidoWebService[0]['proyectos']
                [posicionListaProyectosSeleccionado]['datos']
            ['periodoIdSeleccionado'];
      });
    } else {
      if (contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']['periodos']
              .length >
          0) {
        setState(() {
          periodoIdSeleccionado = contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']['periodos'][0]
              ['periodoId'];
        });
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['periodoIdSeleccionado'] = contenidoWebService[0]
                ['proyectos'][posicionListaProyectosSeleccionado]['datos']
            ['periodos'][0]['periodoId'];
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['porcentajeValorProyectadoSeleccionado'] =
            contenidoWebService[0]['proyectos']
                    [posicionListaProyectosSeleccionado]['datos']['periodos'][0]
                ['porcentajeProyectado'];
      }
    }
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
        ['datos']['porcentajeValorEjecutado'] = porcentajeAsiVa;
    activarVariablesPreferences();
  }

  // Seleccione el periodo a reportar
  int posicionPeriodoReportado = 0;
  int periodoIdSeleccionado = 0;

  cambiarPosicionPeriodoReportado(nuevaPosicion) {
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
        ['datos']['periodoIdSeleccionado'] = contenidoWebService[0]['proyectos']
            [posicionListaProyectosSeleccionado]['datos']['periodos']
        [nuevaPosicion]['periodoId'];
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['porcentajeValorProyectadoSeleccionado'] =
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['periodos'][nuevaPosicion]['porcentajeProyectado'];
    setState(() {
      posicionPeriodoReportado = nuevaPosicion;
      periodoIdSeleccionado = contenidoWebService[0]['proyectos']
              [posicionListaProyectosSeleccionado]['datos']['periodos']
          [nuevaPosicion]['periodoId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          contenidoWebService[0]['proyectos']
                          [posicionListaProyectosSeleccionado]
                      ['ultimaFechaSincro'] ==
                  null
              ? Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(top: 335.h, left: 28.sp, right: 28.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 13.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 20.0,
                        margin: EdgeInsets.only(bottom: 5.0, right: 10.0),
                        child: Image.asset(
                          'assets/img/Desglose/Demas/icn-alert.png',
                          // width: 100.0,
                        ),
                      ),
                      Expanded(
                          child: Text(
                              // 'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                              'Debes sincronizar el proyecto para poder reportar tu avance',
                              style: TextStyle(
                                fontFamily: "montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xffC1272D),
                              ),
                              textAlign: TextAlign.left))
                    ],
                  ))
              : Text(''),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]
                            ['ultimaFechaSincro'] ==
                        null
                    ? 400.h
                    : 400.h,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _Summary(porcentajeAsiVa: porcentajeAsiVa),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: 28.sp, left: 28.sp, bottom: 5.0),
                        child: Text(
                          'Seleccione el periodo a reportar',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff030303),
                            fontFamily: "montserrat",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      seleccionaPeriodo(
                          context,
                          posicionPeriodoReportado,
                          periodoIdSeleccionado,
                          contenidoWebService[0]['proyectos']
                                  [posicionListaProyectosSeleccionado]['datos']
                              ['periodos'], (posicion) {
                        cambiarPosicionPeriodoReportado(posicion);
                      }),
                    ],
                  )),
                  contenidoWebService[0]['proyectos']
                                  [posicionListaProyectosSeleccionado]
                              ['pendienteAprobacion'] ==
                          true
                      ? Container(
                          width: double.infinity,
                          height: 50.0.h,
                          // margin: EdgeInsets.only(
                          //   top: MediaQuery.of(context).size.height/2.5,
                          //   left: 20.0,
                          //   right: 20.0
                          // ),
                          decoration: BoxDecoration(
                            color: AppTheme.rojoBackground,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 24.sp),
                          padding: EdgeInsets.only(
                              top: 5.0.sp,
                              bottom: 10.0.sp,
                              left: 20.0.sp,
                              right: 20.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                margin:
                                    EdgeInsets.only(bottom: 5.0, right: 10.0),
                                child: Image.asset(
                                  'assets/img/Desglose/Demas/icn-alert.png',
                                  // width: 100.0,
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                      'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                                      // 'Debes sincronizar el proyecto para poder reportar tu avance',
                                      style: AppTheme.parrafoRojo,
                                      textAlign: TextAlign.left))
                            ],
                          ))
                      : Text(''),
                ],
              )),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    Key key,
    @required this.porcentajeAsiVa,
  }) : super(key: key);

  final int porcentajeAsiVa;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f2 = NumberFormat("#,##0.00", "es_AR");
    final dynamic proyectos =
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado];
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0, left: 28.sp, right: 28.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
      ),
      padding:
          EdgeInsets.only(top: 10.0, bottom: 20.0, left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          _Celdas(
            leftText: 'Presupuesto',
            rightText: '\$ ${f2.format(proyectos['valorproyecto'])}',
          ),
          _Celdas(
            leftText: 'Asi va',
            rightText: '$porcentajeAsiVa%',
          ),
          _Celdas(
            leftText: 'Asi deberia ir',
            rightText: '${proyectos['porcentajeProyectado'].round()}%',
          ),
          _Celdas(
            leftText: 'Contratista',
            rightText: '${proyectos['contratista']}',
          ),
          _Celdas(
            leftText: 'Semaforo',
            rightText: '${proyectos['semaforoproyecto']}',
            semaforo: true,
          ),
        ],
      ),
    );
  }
}

class _Celdas extends StatelessWidget {
  const _Celdas({
    Key key,
    this.semaforo = false,
    this.leftText,
    this.rightText,
  }) : super(key: key);

  final bool semaforo;
  final String leftText;
  final String rightText;

  String get iconoSemaforo {
    if (semaforo == true) {
      if (rightText == 'amarillo') {
        return 'semaforo-2';
      }
      if (rightText == 'verde') {
        return 'semaforo-1';
      }
    }
    return 'semaforo-3';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: semaforo
          ? EdgeInsets.only(top: 10.0)
          : EdgeInsets.only(bottom: 10.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border(
            bottom: !semaforo
                ? BorderSide(width: 0.3, color: Colors.black)
                : BorderSide(width: 0.0, color: Colors.white)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$leftText',
              style: TextStyle(
                fontFamily: "montserrat",
                fontSize: 14.sp,
                color: Color(0xff333333),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: semaforo
                ? Container(
                    height: 20.0,
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/Desglose/Home/' + iconoSemaforo + '.png',
                        ),
                      ],
                    ),
                  )
                : Text(
                    rightText == 'null' ? '---' : '$rightText',
                    style: TextStyle(
                      fontSize: 13.93.sp,
                      fontFamily: "montserrat",
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
