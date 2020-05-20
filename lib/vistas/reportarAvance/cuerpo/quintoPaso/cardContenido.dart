import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

Widget cardContenidoQuintoPaso(
  context, 
  String titulo,
  String asivaTxt,
  String porcentajeAsiVa,
  String porcentajeAsiVaDos,
  String dineroAsiVa,
  String deberiaIrTxt,
  String porcentajeDeberiaIr,
  String dineroDeberiaIr,
  bool esAntes,
  String semaforo
)
{
  String nombreSemaforo = 'rojo';
  if(esAntes){
    nombreSemaforo = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['semaforoproyecto'];
  }else{
    var datoVerde = (100-((double.parse('$porcentajeAsiVaDos') / contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado'])*100));
    if(datoVerde <= contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['limitePorcentajeAtraso']){
      nombreSemaforo = 'verde';
    }else if( datoVerde > contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['limitePorcentajeAtraso'] && datoVerde <= contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['limitePorcentajeAtrasoAmarillo'] ){
      nombreSemaforo = 'amarillo';
    }else if( datoVerde > contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['limitePorcentajeAtrasoAmarillo'] ){
      nombreSemaforo = 'rojo';
    }
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/3.4,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          blurRadius: 10.0,
          spreadRadius: 0.1,
          offset: Offset(
            0.9,
            0.9,
          ),
        )
      ],
    ),
    child: Container(
      padding: EdgeInsets.only(
        top: 23.0,
        left: 23.0,
        right: 23.0 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[ 
          Text(
            '$titulo',
            textAlign: TextAlign.start,
            style: TextStyle( 
              fontFamily: 'montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppTheme.segundo,
            ),
          ),
          celdas(
            '$asivaTxt',
            '$porcentajeAsiVa%', 
            '\$ $dineroAsiVa', 
            false,
            ''
          ),
          celdas(
            '$deberiaIrTxt',
            '$porcentajeDeberiaIr%', 
            '\$ $dineroDeberiaIr',
            false,
            ''
          ),
          celdas(
            'Semaforo',
            'segundo', 
            'tercero', 
            true,
            nombreSemaforo
          )
          
        ],
      )
    )
  );
}

Widget celdas(txtPrimero, txtSegundo, txtTercero,semaforo, nombreSemaforo)
{
   String iconoSemaforo = 'semaforo-3';
   if(nombreSemaforo == 'rojo'){
      iconoSemaforo = 'semaforo-3';
    }else if(nombreSemaforo == 'amarillo'){
      iconoSemaforo = 'semaforo-2';
    }else if(nombreSemaforo == 'verde'){
      iconoSemaforo = 'semaforo-1';
    }

  return Container(
    padding: EdgeInsets.only(bottom:10.0, top: 15.0),
    decoration: BoxDecoration(
      border: semaforo != true
      ?Border(
        bottom: BorderSide(width: 0.2, color: Colors.black),
      )
      :Border(
        bottom: BorderSide(width: 0.0, color: Colors.white),
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 80.0,
          child: Text(
            '$txtPrimero',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.darkText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        semaforo == true
        ?Container(
          height: 20.0,
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/img/Desglose/Home/${iconoSemaforo}.png',
                height: 15.0,
              )
            ],
          )
        )
        :Container(
          height: 20.0,
          width: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$txtSegundo',
                style: AppTheme.parrafo
              )
            ],
          )
        ),

        semaforo == false
        ?Expanded(
          child: Text(
            '$txtTercero',
            style: AppTheme.parrafo,
            textAlign: TextAlign.start,
          ),
        )
        :Expanded(
          child: Text(''),
        )
        
      ],
    )
  );
}