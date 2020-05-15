import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';


Widget seleccionaPeriodo(context, int posicionPeriodoReportado, int idPeriodoSeleccionado, valores, accion)
{

  List<int> nuevosValores = [];
  for(int cont = 0; cont < valores.length; cont++){
    nuevosValores.add(cont);
    if( valores[cont]['periodoId'] ==  idPeriodoSeleccionado){
      accion(
        cont
      );
    }
  }
  String fechaIniPeriodo;
  String fechaFinPeriodo;
  if(valores.length <= 0){
    fechaIniPeriodo = '';
    fechaFinPeriodo = '';
  }else{
    fechaIniPeriodo = '${valores[posicionPeriodoReportado]['fechaIniPeriodo']}';
    fechaFinPeriodo = '${valores[posicionPeriodoReportado]['fechaFinPeriodo']}';
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    height: 45.0,
    margin: EdgeInsets.only(
      bottom: 10.0
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      border: Border(
        top: BorderSide(
          width: 0.5, 
          color: AppTheme.cuarto
        ),
        left: BorderSide(
          width: 0.5, 
          color: AppTheme.cuarto
        ),
        right: BorderSide(
          width: 0.5, 
          color: AppTheme.cuarto
        ),
        bottom: BorderSide(
          width: 0.5, 
          color: AppTheme.cuarto
        ),
      ),
    ),
    padding: EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/img/Desglose/Home/icn-reloj.png',
            height: 50.0,
          )
        ),
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
                      style: AppTheme.parrafo
                    ),
                    Text(
                      // valores[posicionPeriodoReportado]['fechaIniPeriodo'],
                      '$fechaIniPeriodo',
                      style: AppTheme.parrafoNegrita
                    ),
                    Text(
                      'hasta el ',
                      style: AppTheme.parrafo
                    ),
                    Text(
                      // valores[posicionPeriodoReportado]['fechaFinPeriodo'],
                      '$fechaFinPeriodo',
                      style: AppTheme.parrafoNegrita
                    ),
                  ],
                )
              ),
              items: nuevosValores.map((value) => DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Text(
                      'del ',
                      style: AppTheme.parrafo
                    ),
                    Text(
                      valores[value]['fechaIniPeriodo'],
                      style: AppTheme.parrafoNegrita
                    ),
                    Text(
                      ' hasta el ',
                      style: AppTheme.parrafo
                    ),
                    Text(
                      valores[value]['fechaFinPeriodo'],
                      style: AppTheme.parrafoNegrita
                    ),
                  ],
                ),
                value: value,
              )).toList(),
              onChanged: accion
            ),
          )
        )
      ],
    )
  );
}