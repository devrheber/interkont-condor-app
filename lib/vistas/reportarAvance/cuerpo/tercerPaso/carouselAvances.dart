import 'package:appalimentacion/globales/variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselAlcance(context)
{
  List lista = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'];
  return CarouselSlider(
    enableInfiniteScroll: false,
    enlargeCenterPage: true,
    height: 260.0,
    items: <Widget>[
      for(int cont=0; cont < lista.length; cont++)
      Container(
        margin: EdgeInsets.only(
          right: 10.0
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only( 
            topLeft:     Radius.circular(15.0),
            topRight:    Radius.circular(15.0),
            bottomLeft:  Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xff0c81ab),
              Color(0xff2eac78)
            ],
          ),
        ),
        padding: EdgeInsets.only(left:20.0, right: 20.0, top: 35.0, bottom: 15.0),
        child: ListView(
          children: <Widget>[
            Text(
              lista[cont]['descripcionIndicadorAlcance'],
              style: TextStyle(
                fontSize: 15.0, 
                color: Colors.white,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.bold
              ), 
              
              textAlign: TextAlign.center),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Ingresa la ejecucion', 
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
              textAlign: TextAlign.center
            ),
            Container(
              margin: EdgeInsets.only(left:25.0, right: 25.0, top: 5.0, bottom: 25.0),
              height: 50.0,
              decoration: const BoxDecoration(
                color: Color(0xFF48b3a1),
                borderRadius: BorderRadius.only( 
                  topLeft:     Radius.circular(15.0),
                  topRight:    Radius.circular(15.0),
                  bottomLeft:  Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                        hintText: "500",
                        hintStyle: TextStyle(
                          fontSize: 20.0, 
                          color: Colors.white,
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold
                        ), 
                      )
                    ),
                  )
                ],
              )
            ),
            Column(
              children: <Widget>[
                celdas(
                  'Unidad de medida',
                  lista[cont]['unidadMedida'],
                  false
                ),
                celdas(
                  'Cantidad programada',
                  lista[cont]['cantidadProgramada'],
                  false
                ),
                celdas(
                  'Cantidad ejecutada',
                  lista[cont]['cantidadEjecutada'],
                  true
                ),
                celdas(
                  'Porcentaje de avance',
                  '${lista[cont]['porcentajeAvance']}%',
                  true
                ),
              ],
            )
          ],
        )
      )
    ],
  );          
}

Widget celdas(txtIzquierda, txtDerecha, negrita)
{
  FontWeight fontWeight = FontWeight.w200;
  if(negrita == true){
    fontWeight = FontWeight.w600;
  }
  return Container(
    padding: EdgeInsets.only(bottom:5.0, top: 5.0, left: 5.0, right: 5.0),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 0.3, 
          color: Colors.white
        ),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            '$txtIzquierda', 
            style: TextStyle( 
              fontFamily: 'montserrat',
              fontWeight: fontWeight,
              fontSize: 10,
              color: Colors.white
            )
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$txtDerecha', 
            style: TextStyle( 
              fontFamily: 'montserrat',
              fontWeight: fontWeight,
              fontSize: 10,
              color: Colors.white
            ),
            textAlign: TextAlign.right,
          ), 
        )
        
      ],
    )
  );
}