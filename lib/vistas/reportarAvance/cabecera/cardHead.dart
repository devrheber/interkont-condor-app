import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final titleColor = Color(0xff444444);

Widget pasos(context, pasoSeleccionado)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/8,
    margin: EdgeInsets.only( top: MediaQuery.of(context).size.height/4, right: 20.0, left: 20.0),
    // margin: EdgeInsets.only(top: 40.0,right: 20, left: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: titleColor.withOpacity(.1),
          blurRadius: 20,
          spreadRadius: 10
        ),
      ]
    ),
    child: Container(
      child: Row(
        children: <Widget>[ 
          
          paso(
            'Ingrese el avance', 
            1,
            pasoSeleccionado
          ),
          paso(
            'Avance cualitativo', 
            2,
            pasoSeleccionado
          ),
          paso(
            'Indicador de alcance', 
            3,
            pasoSeleccionado
          ),
          paso(
            'Descripción & Documentos', 
            4,
            pasoSeleccionado
          ),
        ],
      )
    )
  );
}


Widget paso(texto, numero, pasoSeleccionado)
{
  Color contenidoNumero = Colors.white;
  FontWeight colorLetra = FontWeight.w200;

  if(numero <= pasoSeleccionado  ){
    contenidoNumero = AppTheme.segundo;
  }else{
    contenidoNumero = AppTheme.dieciseisavo;
  }
  
  if(numero == pasoSeleccionado){
    colorLetra = FontWeight.w700;
  }

  return Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0, 
            color: contenidoNumero
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:10.0, bottom: 10.0, left: 12.0, right: 12.0),
            margin: EdgeInsets.only(bottom:5.0),
            decoration: BoxDecoration(
              color: contenidoNumero,
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
            ),
            child: Text(
              '$numero',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.5, color: Colors.white),  
            )
          ),
          Text(
            '$texto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.5,
              color: AppTheme.darkText,
              fontWeight: colorLetra,
            ),
          )
        ],
      ),
    )
  );
}