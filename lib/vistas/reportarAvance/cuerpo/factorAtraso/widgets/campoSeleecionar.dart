
import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget campoSeleccionar(String txtHint, String nombreObj, int posicionPeriodoReportado, valores, accion)
{
  List<int> nuevosValores = [];
  for(int cont = 0; cont < valores.length; cont++){
    nuevosValores.add(cont);
  }
  return Container(
    padding: EdgeInsets.only(
      left: 10.0,
      right: 10.0
    ),
    margin: EdgeInsets.only(
      bottom: 5.0
    ),
    decoration: BoxDecoration(
      color: Color.fromRGBO(1, 1, 1, 0.1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        iconEnabledColor: Colors.white,
        isExpanded: true,
        hint: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            children: <Widget>[
              Text(
                '$txtHint',
                style: AppTheme.parrafoBlanco
              ),
            ],
          )
        ),
        items: nuevosValores.map((value) => DropdownMenuItem(
          child: Text(
            valores[value][nombreObj]
          ),
          value: value,
        )).toList(),
        onChanged: accion
      ),
    ),
  );
}