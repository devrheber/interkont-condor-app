import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

Widget cajonTexto(context, textoTitulo, textoHint, logros, capturarCambio, TextEditingController controller )
{
    
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120.0,
    margin: EdgeInsets.only(top:10.0),
    padding: EdgeInsets.only(
      left:15.0, 
      right: 15, 
      top:10
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only( right:10.0,),
              child: 
              logros == true
              ?Image.asset(
                'assets/img/Desglose/ReporteAvance/icn-logros.png',
                width: 20.0,
              )
              :Image.asset(
                'assets/img/Desglose/ReporteAvance/icn-dificultades.png',
                width: 20.0,
              )
            ),
            Expanded(
              child: Text(
                '$textoTitulo',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 13,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w300,
                ),
              )
            )
          ],
        ),

        Container(
          padding: EdgeInsets.only(top:10.0),
          child: TextField(
            textInputAction: TextInputAction.send,
            controller: controller,
            onChanged: capturarCambio,
            maxLines: 2,
            decoration: InputDecoration.collapsed(
              hintText: "$textoHint",
              hintStyle: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w100,
                fontSize: 13
              )
            )
          )
        )
      ],
    )
  );
}