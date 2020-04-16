import 'package:appalimentacion/globales/colores.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselAlcance(context)
{
  return CarouselSlider(
    enableInfiniteScroll: false,
    enlargeCenterPage: true,
    height: 250.0,
    items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 250.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only( 
                topLeft:     Radius.circular(15.0),
                topRight:    Radius.circular(15.0),
                bottomLeft:  Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  AppTheme.primero,
                  AppTheme.segundo,
                  AppTheme.tercero,
                ],
              ),
            ),
            padding: EdgeInsets.only(left:20.0, right: 20.0, top: 35.0, bottom: 15.0),
            child: ListView(
              children: <Widget>[
                Text(
                  'Personas Beneficiadas', 
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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
                    borderRadius: BorderRadius.only( 
                      topLeft:     Radius.circular(15.0),
                      topRight:    Radius.circular(15.0),
                      bottomLeft:  Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppTheme.noveno,
                        AppTheme.noveno,
                      ],
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
                              fontWeight: FontWeight.w700,
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
                      'UND'
                    ),
                    celdas(
                      'Cantidad programada',
                      '15.000'
                    ),
                    celdas(
                      'Ejecutado a la fecha',
                      '50%'
                    ),
                  ],
                )
              ],
            )
          );


        },
      );
    }).toList(),
  );          
}

Widget celdas(txtIzquierda, txtDerecha)
{
  return Container(
    padding: EdgeInsets.only(bottom:5.0, top: 5.0, left: 5.0, right: 5.0),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.white),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '$txtIzquierda', 
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '$txtDerecha', 
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.right,
          ), 
        )
        
      ],
    )
  );
}