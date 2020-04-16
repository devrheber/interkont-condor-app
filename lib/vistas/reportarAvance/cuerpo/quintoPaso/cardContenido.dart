import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

Widget cardContenidoQuintoPaso(context, titulo)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/3.4,
    // margin: EdgeInsets.only( top: MediaQuery.of(context).size.height/10, right: 20.0, left: 20.0),
    // margin: EdgeInsets.only(top: 40.0,right: 20, left: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[ 
          Text(
            '$titulo',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppTheme.segundo,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          celdas('Asi va', '67%', '\$ 3.255.255.542',false),
          celdas('Deberia ir', '76%', '\$ 3.255.255.542',false),
          celdas('Semaforo', 'segundo', 'tercero',true)
          
        ],
      )
    )
  );
}

Widget celdas(txtPrimero, txtSegundo, txtTercero,semaforo)
{
  return Container(
    padding: EdgeInsets.only(bottom:10.0, top: 15.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '$txtPrimero',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.darkText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: 
          semaforo == true
          ?Container(
            height: 20.0,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/img/Desglose/Home/semaforo-3.png',
                  alignment: Alignment.topLeft,
                ),
              ],
            )
          )
          :Text(
            '$txtSegundo',
            style: AppTheme.parrafo
          )
        ),

        semaforo == false
        ?Expanded(
          child: Text(
            '$txtTercero',
            style: AppTheme.parrafo
          ),
        )
        :Expanded(
          child: Text(''),
        )
        
      ],
    )
  );
}