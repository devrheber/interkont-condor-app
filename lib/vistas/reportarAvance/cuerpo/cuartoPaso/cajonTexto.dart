import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final titleColor = Color(0xff444444);
Widget cajonTextoComentarios(context, textoTitulo, textoHint, accion )
{
  TextEditingController controllerCuartoPasoTxtComentarios = TextEditingController();
  if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'] != null){
    controllerCuartoPasoTxtComentarios.text = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'];
  }
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
                FontAwesomeIcons.comments,
                size: 20,
                color: AppTheme.primario,
              ),
            ),
            Expanded(
              child: Text(
                '$textoTitulo'
              )
            )
          ],
        ),

        Container(
          padding: EdgeInsets.only(top:10.0),
          child: TextField(
            textInputAction: TextInputAction.send,
            controller: controllerCuartoPasoTxtComentarios,
            onChanged: accion,
            maxLines: 4,
            decoration: InputDecoration.collapsed(
              hintText: "$textoHint",
              hintStyle: TextStyle(
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