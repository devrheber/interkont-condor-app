import 'package:appalimentacion/app/data/model/datos_alimentacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../globales/colores.dart';

// Widget seleccionaPeriodo(context, int posicionPeriodoReportado,
//     int idPeriodoSeleccionado, valores, accion) {

Widget seleccionaPeriodo(
    {context,
    int posicionPeriodoReportado,
    int idPeriodoSeleccionado,
    List<Periodo> valores,
    accion}) {
  List<int> nuevosValores = [];
  for (int cont = 0; cont < valores.length; cont++) {
    nuevosValores.add(cont);
    // if (valores[cont]['periodoId'] == idPeriodoSeleccionado) {
    if (valores[cont].periodoId == idPeriodoSeleccionado) {
      accion(cont);
    }
  }
  String fechaIniPeriodo;
  String fechaFinPeriodo;
  if (valores.length <= 0) {
    fechaIniPeriodo = '';
    fechaFinPeriodo = '';
  } else {
    // fechaIniPeriodo = '${valores[posicionPeriodoReportado]['fechaIniPeriodo']}';
    //   fechaFinPeriodo = '${valores[posicionPeriodoReportado]['fechaFinPeriodo']}';
    fechaIniPeriodo = '${valores[posicionPeriodoReportado].fechaIniPeriodo}';
    fechaFinPeriodo = '${valores[posicionPeriodoReportado].fechaFinPeriodo}';
  }

  var preposition = TextStyle(
    color: Color(0xff556A8D),
    fontFamily: 'montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 13.sp,
  );
  var dates = TextStyle(
    color: Colors.black,
    fontFamily: 'montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
  );
  return Container(
      width: double.infinity,
      height: 58.0.sp,
      margin: EdgeInsets.only(
        bottom: 10.0,
        right: 28.sp,
        left: 28.sp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border(
          top: BorderSide(width: 0.5, color: AppTheme.cuarto),
          left: BorderSide(width: 0.5, color: AppTheme.cuarto),
          right: BorderSide(width: 0.5, color: AppTheme.cuarto),
          bottom: BorderSide(width: 0.5, color: AppTheme.cuarto),
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Image.asset(
                'assets/img/Desglose/Home/icn-reloj.png',
                height: 17.82.sp,
                width: 17.82.sp,
              )),
          Expanded(
              flex: 6,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'del ',
                            style: preposition,
                          ),
                          Text(
                              // valores[posicionPeriodoReportado]['fechaIniPeriodo'],
                              '$fechaIniPeriodo',
                              style: dates),
                          Text(' hasta el ', style: preposition),
                          Text(
                              // valores[posicionPeriodoReportado]['fechaFinPeriodo'],
                              '$fechaFinPeriodo',
                              style: dates),
                        ],
                      ),
                    ),
                    items: nuevosValores
                        .map((value) => DropdownMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Text('del ', style: AppTheme.parrafo),
                                  // Text(valores[value]['fechaIniPeriodo'],
                                  Text(valores[value].fechaIniPeriodo,
                                      style: AppTheme.parrafoNegrita),
                                  Text(' hasta el ', style: AppTheme.parrafo),
                                  // Text(valores[value]['fechaFinPeriodo'],
                                  Text(valores[value].fechaFinPeriodo,
                                      style: AppTheme.parrafoNegrita),
                                ],
                              ),
                              value: value,
                            ))
                        .toList(), 
                    onTap: () => print("object"),
                    onChanged: accion),
              ))
        ],
      ));
}
