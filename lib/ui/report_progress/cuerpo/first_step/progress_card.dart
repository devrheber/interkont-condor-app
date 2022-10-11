import 'package:appalimentacion/domain/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../../helpers/decimal_formatter.dart';
import '../../../../theme/color_theme.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({
    Key key,
    @required this.valueSaved,
    @required this.activity,
    @required this.onChanged,
  }) : super(key: key);

  final String valueSaved;
  final Actividad activity;
  final Function(String) onChanged;

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  TextEditingController controllerPrimerPasoTxtAvance;
  String valueSaved;

  double cantidadEjecutada;
  double valorEjecutado;
  double porcentajeAvance;
  double faltantePorEjecutar;

  @override
  void initState() {
    super.initState();
    valueSaved = widget.valueSaved == '' ? '0' : widget.valueSaved;
    controllerPrimerPasoTxtAvance = TextEditingController();

    controllerPrimerPasoTxtAvance.text = valueSaved;
    calcutate(valueSaved);
  }

  @override
  void dispose() {
    controllerPrimerPasoTxtAvance.dispose();
    super.dispose();
  }

  void calcutate(String stringValue) {
    String value = stringValue == '' ? '0' : stringValue;
    if (double.parse('$value') < 0) {
      Toast.show(
        "Lo sentimos, solo aceptamos numeros positivos",
        context,
        duration: 3,
        gravity: Toast.BOTTOM,
      );
    } else if (double.parse('$value') > 100) {
      Toast.show(
        "El valor ejecutado de la actividad no puede superar el 100%",
        context,
        duration: 3,
        gravity: Toast.BOTTOM,
      );
    } else {
      cantidadEjecutada =
          widget.activity.cantidadEjecutadaInicial + double.parse('$value');
      valorEjecutado = multCantidadEjecutadaValorUnitario();
      porcentajeAvance = calcPorcentajeAvanzado();
      faltantePorEjecutar = calcPorcFaltantePorEjecutar();
      // calcularValorEjecutado();
    }

    // TODO save value in cache
    widget.onChanged(value);
    setState(() {});
  }

  double calcPorcentajeAvanzado() {
    return widget.activity.valorEjecutado / widget.activity.valorProgramado * 100;
  }

  double multCantidadEjecutadaValorUnitario() {
    return widget.activity.cantidadEjecutada * widget.activity.valorUnitario;
  }

  double calcPorcFaltantePorEjecutar() {
    return 100.0 - cantidadEjecutada;
  }

  // bool descripcionActividad(dynamic actividades, int cont) {
  //   return actividades[cont]['descripcionActividad']
  //               .indexOf(txtBuscarAvance.toUpperCase()) !=
  //           -1 ||
  //       actividades[cont]['descripcionActividad']
  //               .indexOf(txtBuscarAvance.toLowerCase()) !=
  //           -1;
  // }

  @override
  Widget build(BuildContext context) {
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
          Text(widget.activity.descripcionActividad,
              style: TextStyle(
                fontSize: 12.1796.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'montserrat',
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 16.93.sp),
          Text(
            'Ingresa el % de avance para el presente reporte',
            style: TextStyle(
              fontSize: 12.18.sp,
              color: Colors.white,
              fontFamily: "montserrat",
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
                      // textInputAction: TextInputAction.done,
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2),
                      ],
                      controller: controllerPrimerPasoTxtAvance,
                      onChanged: calcutate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: "0.0",
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
          Spacer(),
          Column(
            children: <Widget>[
              _Celdas(
                label: 'Ejecutado Actual',
                value: widget.activity.cantidadEjecutadaInicial.toString(),
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Avance del presente reporte',
                value: controllerPrimerPasoTxtAvance.text,
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Avance a hoy',
                value: cantidadEjecutada.toString(),
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Faltante por ejecutar',
                value: faltantePorEjecutar.toString(),
                isNumericVariable: false,
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class _Celdas extends StatelessWidget {
  const _Celdas({
    Key key,
    @required this.label,
    @required this.value,
    this.bold = false,
    this.isNumericVariable = true,
  }) : super(key: key);
  final String label;
  final String value;
  final bool bold;
  final bool isNumericVariable;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = bold ? FontWeight.w700 : FontWeight.w300;
    String newValue = value;
    if (isNumericVariable) {
      NumberFormat nFormatOneDecimal = NumberFormat("#,##0.0", "es_AR");
      NumberFormat nFormatTwoDecimal = NumberFormat("#,##0.00", "es_AR");

      List<String> valueSplitted = value.split(" ");

      if (valueSplitted.length > 1) {
        //SI AL FINAL TIENE EL SIMBOLO %
        if (valueSplitted[1] == '%') {
          newValue = nFormatOneDecimal.format(double.parse(valueSplitted[0])) +
              " " +
              valueSplitted[1];
        } else {
          newValue = valueSplitted[0] +
              " " +
              nFormatTwoDecimal.format(double.parse(valueSplitted[1]));
        }
      } else {
        newValue = nFormatOneDecimal.format(double.parse(valueSplitted[0]));
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
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: fontWeight,
                fontSize: 12.18.sp,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              newValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: fontWeight,
                fontSize: 12.18.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
