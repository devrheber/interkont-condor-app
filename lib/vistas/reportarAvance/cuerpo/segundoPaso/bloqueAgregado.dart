import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget bloqueAgregado(context, textoTitulo, textoHint )
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
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                'Administrativo',
                style: AppTheme.h2,
              ),
            ),
            Expanded(
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
              ),
              Text(
                'lorem ipsum dolor text otros a la bin bin que refurinfunflay asda asdas asd adas dasd asd',
                style: AppTheme.parrafo,
              ),

              SizedBox(
                height: 10.0,
              ),

              Text(
                'DIFICULTADES',
                style: AppTheme.tituloParrafo,
              ),
              Text(
                'lorem ipsum dolor text otros a la bin bin que refurinfunflay asda asdas asd adas dasd asd',
                style: AppTheme.parrafo,
              ),

            ],
          ),
        )
      ],
    )
  );
}