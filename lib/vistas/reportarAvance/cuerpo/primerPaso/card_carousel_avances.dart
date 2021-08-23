import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Widget cardCarousel1(
    calcularPorcentajeValorEjecutado,
    String descripcionActividad,
    unidadMedida,
    valorUnitario,
    cantidadProgramada,
    valorProgramado,
    double cantidadEjecutada,
    valorEjecutado,
    porcentajeAvance,
    txtActividadAvance,
    accion) {
  calcularPorcentajeValorEjecutado();
  TextEditingController controllerPrimerPasoTxtAvance = TextEditingController();

  if (txtActividadAvance != null && txtActividadAvance != '') {
    controllerPrimerPasoTxtAvance.text = txtActividadAvance;
  } else {}

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
      margin: EdgeInsets.only(bottom: 38.sp),
      child: Column(
        children: <Widget>[
          Text(descripcionActividad,
              style: TextStyle(
                fontSize: 12.1796.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'montserrat',
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 16.93.sp),
          Text('Ingresa el avance',
              style: TextStyle(
                fontSize: 12.18.sp,
                color: Colors.white,
                fontFamily: "montserrat",
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center),
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
                        // textInputAction: TextInputAction.done,
                        textInputAction: TextInputAction.send,
                        controller: controllerPrimerPasoTxtAvance,
                        onChanged: accion,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
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
              )),
          SizedBox(height: 50.88.sp),
          Column(
            children: <Widget>[
              celdas('Unidad de medida', unidadMedida, false, false, 0),
              celdas('Valor Unitario', '\$ $valorUnitario', false, true, 2),
              celdas('Cant. Programada', '$cantidadProgramada', false, true, 1),
              celdas('Valor Programado', '\$ $valorProgramado', false, true, 2),
              celdas('Cant. Ejecutada', '$cantidadEjecutada', true, true, 1),
              celdas('Valor Ejecutado', '\$ $valorEjecutado', true, true, 2),
              celdas('Avance a hoy', '$porcentajeAvance %', true, true, 1),
            ],
          )
        ],
      ));
}

Widget celdas(txtIzquierda, txtDerecha, negrita, bool variableNumerica,
    int numeroDecimales) {
  FontWeight fontWeight = FontWeight.w300;
  if (negrita == true) {
    fontWeight = FontWeight.w700;
  }

  if (variableNumerica == true) {
    List derecha = txtDerecha.split(" ");

    if (derecha.length > 1) {
      if (derecha[1] == '%') {
        NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
        txtDerecha = f.format(double.parse(derecha[0])) + " " + derecha[1];
        // txtDerecha = '${derecha[0]}'+" "+derecha[1];
        // txtDerecha = double.parse(derecha[0]).toStringAsFixed(numeroDecimales)+" "+derecha[1];
      } else {
        NumberFormat f = new NumberFormat("#,##0.00", "es_AR");
        txtDerecha = derecha[0] + " " + f.format(double.parse(derecha[1]));
      }
    } else {
      NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
      txtDerecha = f.format(double.parse(derecha[0]));
      // txtDerecha =double.parse(derecha[0]).toStringAsFixed(numeroDecimales);
    }
  }

  return Container(
      padding: EdgeInsets.only(bottom: 3.9.sp, top: 5.3.sp),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2.sp, color: Colors.white),
          top: BorderSide(width: 0.2.sp, color: Colors.white),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('$txtIzquierda',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: fontWeight,
                    fontSize: 12.18.sp,
                    color: Colors.white)),
          ),
          Expanded(
            child: Text(
              '$txtDerecha',
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: fontWeight,
                  fontSize: 12.18.sp,
                  color: Colors.white),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ));
}
