
import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget factorRegistrado(int posicion, String txtTipo, String txtFactor, accionEliminar )
{
  int numeroFactor = posicion+1;
  return Container(
    padding: EdgeInsets.all(15.0),
    margin: EdgeInsets.only(
      bottom: 5.0
    ),
    decoration: BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      borderRadius: BorderRadius.circular(15.0)
    ),
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: accionEliminar,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Factor $numeroFactor',
                  style: AppTheme.parrafoBlancoNegrita
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 5.0
                ),
                child: Text(
                  'Eliminar',
                  style: AppTheme.parrafoBlanco,
                ),
              ),
              Image.asset(
                'assets/img/Desglose/Demas/btn-delete.png',
                width: 25.0,
                height: 25.0,
              )
            ],
          ),
        ),

        SizedBox(
          height: 10.0,
        ),


        Row(
          children: <Widget>[
            Container(
              width: 50.0,
              child: Text(
                'Tipo',
                style: AppTheme.parrafoBlancoNegrita,
              ),
            ),
            Text(
              '$txtTipo',
              style: AppTheme.parrafoBlanco,
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 50.0,
              child: Text(
                'Factor',
                style: AppTheme.parrafoBlancoNegrita,
              ),
            ),
            Expanded(
              child: Text(
                '$txtFactor',
                style: AppTheme.parrafoBlanco,
              )
            )
          ],
        ),
      ],
    ),
  );
}