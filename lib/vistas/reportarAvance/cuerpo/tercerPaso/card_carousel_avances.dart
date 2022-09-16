import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../theme/color_theme.dart';

Widget cardCarousel3(
    descripcionIndicadorAlcance,
    unidadMedida,
    cantidadProgramada,
    cantidadEjecutada,
    porcentajeAvance,
    txtEjecucionIndicadorAlcance,
    accion) {
  NumberFormat f = new NumberFormat("#,##0.0", "es_AR");

  TextEditingController controllerTercerPasoTxtEjecucion =
      TextEditingController();
  if (txtEjecucionIndicadorAlcance != null) {
    controllerTercerPasoTxtEjecucion.text = txtEjecucionIndicadorAlcance;
  }

  return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff666666).withOpacity(0.26),
              blurRadius: 14.sp,
              spreadRadius: 0.4.sp,
              offset: Offset(4.sp, 10.sp)),
        ],
        borderRadius: BorderRadius.circular(16.13.sp),
        gradient: ColorTheme.cardGradient,
      ),
      padding: EdgeInsets.only(
        left: 38.46.sp,
        right: 37.42.sp,
        top: 30.64.sp,
        bottom: 38.95.sp,
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Text(descripcionIndicadorAlcance,
              style: TextStyle(
                fontSize: 12.18.sp,
                color: Colors.white,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 16.84.sp),
          Text(
            'Ingresa la ejecucion',
            style: TextStyle(
              fontSize: 12.18.sp,
              color: Colors.white,
              fontFamily: 'montserrat',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 9.68.sp),
          Container(
            height: 41.13.sp,
            width: 177.4.sp,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12.0957.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 12.1.sp,
                  spreadRadius: 0,
                  offset: Offset(2.42.sp, 3.12.sp),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      controller: controllerTercerPasoTxtEjecucion,
                      onChanged: accion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: "0",
                        hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffE3E3E3),
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 50.88.sp),
          Column(
            children: <Widget>[
              celdas('Unidad de medida', unidadMedida, false),
              celdas('Cantidad programada',
                  f.format(double.parse('$cantidadProgramada')), false),
              celdas('Cantidad ejecutada',
                  f.format(double.parse('$cantidadEjecutada')), true),
              celdas('Porcentaje de avance',
                  f.format(double.parse('$porcentajeAvance')) + '%', true),
            ],
          )
        ],
      ));
}

Widget celdas(txtIzquierda, txtDerecha, negrita) {
  FontWeight fontWeight = FontWeight.w200;
  if (negrita == true) {
    fontWeight = FontWeight.w600;
  }
  return Container(
      padding: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.3, color: Colors.white),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$txtIzquierda',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: fontWeight,
                    fontSize: 10,
                    color: Colors.white)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$txtDerecha',
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: fontWeight,
                  fontSize: 10,
                  color: Colors.white),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ));
}
