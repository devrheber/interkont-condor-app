import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

Widget cardContenidoQuintoPaso({
  String titulo,
  String asivaTxt,
  String porcentajeAsiVa,
  String porcentajeAsiVaDos,
  String dineroAsiVa,
  String deberiaIrTxt,
  String porcentajeDeberiaIr,
  String dineroDeberiaIr,
  bool esAntes,
  String semaforo,
}) {
  String nombreSemaforo = 'rojo';
  if (esAntes) {
    nombreSemaforo = contenidoWebService[0]['proyectos']
        [posicionListaProyectosSeleccionado]['semaforoproyecto'];
  } else {
    var datoVerde = (100 -
        ((double.parse('$porcentajeAsiVaDos') /
                contenidoWebService[0]['proyectos']
                        [posicionListaProyectosSeleccionado]['datos']
                    ['porcentajeValorProyectadoSeleccionado']) *
            100));
    if (datoVerde <=
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['limitePorcentajeAtraso']) {
      nombreSemaforo = 'verde';
    } else if (datoVerde >
            contenidoWebService[0]['proyectos']
                    [posicionListaProyectosSeleccionado]['datos']
                ['limitePorcentajeAtraso'] &&
        datoVerde <=
            contenidoWebService[0]['proyectos']
                    [posicionListaProyectosSeleccionado]['datos']
                ['limitePorcentajeAtrasoAmarillo']) {
      nombreSemaforo = 'amarillo';
    } else if (datoVerde >
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['limitePorcentajeAtrasoAmarillo']) {
      nombreSemaforo = 'rojo';
    }
  }

  return Container(
      width: double.infinity,
      height: 206.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Container(
          padding: EdgeInsets.only(
              top: 22.sp, left: 23.sp, right: 22.0.sp, bottom: 25.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Text(
                '$titulo',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color:
                      titulo == "Antes" ? Color(0xff5994EF) : Color(0xff7964F3),
                ),
              ),
              celdas(
                txtPrimero: '$asivaTxt',
                txtSegundo: '$porcentajeAsiVa%',
                txtTercero: '\$ $dineroAsiVa',
                semaforo: false,
                nombreSemaforo: '',
              ),
              celdas(
                txtPrimero: '$deberiaIrTxt',
                txtSegundo: '$porcentajeDeberiaIr%',
                txtTercero: '\$ $dineroDeberiaIr',
                semaforo: false,
                nombreSemaforo: '',
              ),
              celdas(
                txtPrimero: 'Semaforo',
                txtSegundo: 'segundo',
                txtTercero: 'tercero',
                semaforo: true,
                nombreSemaforo: nombreSemaforo,
              )
            ],
          )));
}

Widget celdas(
    {String txtPrimero,
    txtSegundo,
    txtTercero,
    nombreSemaforo,
    bool semaforo}) {
  String iconoSemaforo = 'semaforo-3';
  if (nombreSemaforo == 'rojo') {
    iconoSemaforo = 'semaforo-3';
  } else if (nombreSemaforo == 'amarillo') {
    iconoSemaforo = 'semaforo-2';
  } else if (nombreSemaforo == 'verde') {
    iconoSemaforo = 'semaforo-1';
  }

  return Container(
      padding: EdgeInsets.only(bottom: 8.sp, top: 11.sp),
      decoration: BoxDecoration(
        border: semaforo != true
            ? Border(
                bottom: BorderSide(
                  width: 0.3.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            : Border(
                bottom: BorderSide(width: 0.0, color: Colors.white),
              ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 120.sp,
            child: Text(
              '$txtPrimero',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          semaforo == true
              ? Container(
                  child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/img/Desglose/Home/${iconoSemaforo}.png',
                      height: 19.0.sp,
                    )
                  ],
                ))
              : Container(
                  height: 24.sp,
                  width: 80.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$txtSegundo',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xff808080),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )),
          semaforo == false
              ? Expanded(
                  child: Container(
                    child: Text(
                      '$txtTercero',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              : Expanded(
                  child: Text(''),
                )
        ],
      ));
}
