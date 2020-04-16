import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/bloqueAgregado.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/cajonTexto.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/seleccionarAvance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final titleColor = Color(0xff444444);

class CardCuerpoSegundoPaso extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5 , left: 20.0, right: 20.0),
          // color: Colors.black,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 5.0, left:5.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Avance Cualitativo',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '¿Qué logros y dificultades se presentaron?',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    seleccionarAvance(context),
                    cajonTexto(
                      context,
                      'Ingrese los logros',
                      'Aca puede agregar los logros que obtuvo el proyecto..'
                    ),
                    cajonTexto(
                      context,
                      'Ingrese las dificultades',
                      'Aca puede agregar los dificultades que obtuvo el proyecto..'
                    ),
                    GestureDetector(
                      onTap: (){
                        
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:10.0),
                        // color: AppTheme.bottomPrincipal,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only( 
                              topLeft:     Radius.circular(15.0),
                              topRight:    Radius.circular(15.0),
                              bottomLeft:  Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            gradient: LinearGradient(
                              // begin: Alignment.bottomCenter,
                              // end: Alignment.topCenter,
                              colors: <Color>[
                                AppTheme.primero,
                                AppTheme.segundo,
                                AppTheme.tercero,
                              ],
                            ),
                            
                          ),
                          padding: EdgeInsets.only(left:20.0, right: 20.0, top: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only( right:10.0,),
                                      child: Icon(
                                        FontAwesomeIcons.plusCircle,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Añadir',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                      )
                    ),

                    bloqueAgregado(context, '','')
                    
                  ],
                ),
              ),
            ]
          )
        )
      ],
    );
  }
}