import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final titleColor = Color(0xff444444);
Widget cajonTexto(context, textoTitulo, textoHint )
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120.0,
    margin: EdgeInsets.only(top:10.0),
    padding: EdgeInsets.only(left:15.0, right: 15, top:10),
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
              child: Icon(
                FontAwesomeIcons.trophy,
                size: 20,
                color: Colors.yellow,
              ),
            ),
            Expanded(
              child: Text(
                '$textoTitulo',
                style: TextStyle(
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
            maxLines: 2,
            decoration: InputDecoration.collapsed(
              hintText: "$textoHint",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 10
              )
            )
          )
        )
      ],
    )
  );
}