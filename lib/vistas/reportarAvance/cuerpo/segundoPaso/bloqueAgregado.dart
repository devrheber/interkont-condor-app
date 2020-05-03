import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget bloqueAgregado(context, textoTitulo, textoLogro, textoDificultad, accionEliminar )
{
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top:10.0),
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                '$textoTitulo',
                style: AppTheme.h2,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: accionEliminar,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Eliminar',
                      textAlign: TextAlign.end,
                      style: AppTheme.peligro,
                    ),
                    Container(
                      margin: EdgeInsets.only(left:5.0),
                      width: 25.0,
                      child: Image.asset(
                        'assets/img/Desglose/Demas/btn-delete.png',
                      ),
                    )
                  ],
                )
              )
            )
          ],
        ),

        Container(
          padding: EdgeInsets.only(left:10.0, right: 10.0, top: 15.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                'LOGROS',
                style: AppTheme.tituloParrafo,
                textAlign: TextAlign.start,
              ),
              Text(
                '$textoLogro',
                style: AppTheme.parrafo,
                textAlign: TextAlign.start,
              ),

              SizedBox(
                height: 10.0,
              ),

              Text(
                'DIFICULTADES',
                style: AppTheme.tituloParrafo,
                textAlign: TextAlign.start,
              ),
              Text(
                '$textoDificultad',
                style: AppTheme.parrafo,
                textAlign: TextAlign.start,
              ),

            ],
          ),
        )
      ],
    )
  );
}