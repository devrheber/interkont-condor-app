import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/bloqueAgregado.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/cajonTexto.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/seleccionarAvance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final titleColor = Color(0xff444444);

class CardCuerpoSegundoPaso extends StatefulWidget {

  CardCuerpoSegundoPaso({Key key}) : super(key: key);

  @override
  CardCuerpoSegundoPasoState createState() => CardCuerpoSegundoPasoState();
}

class CardCuerpoSegundoPasoState extends State<CardCuerpoSegundoPaso> {

  List listaLogrosDificultades = [];
  String txtLogro = '';
  String txtDificultad = '';
  bool reiniciarLogroDificultad = false;

  TextEditingController controllerLogro = TextEditingController();
  TextEditingController controllerDificultad = TextEditingController();

  @override
  void initState()
  {
    if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'] != null){
      setState(() {
        listaLogrosDificultades = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/3.3, 
            left: 20.0, 
            right: 20.0
          ),
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
                        fontFamily: 'montserrat',
                        fontSize: 17,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '¿Qué logros y dificultades se presentaron?',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 13,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SeleccionarAvance(),
                    cajonTexto(
                      context,
                      'Ingrese los logros',
                      'Aca puede agregar los logros que obtuvo el proyecto..',
                      true,
                      (texto){
                        setState(() {
                          txtLogro = texto;
                        });
                      },
                      controllerLogro
                    ),
                    cajonTexto(
                      context,
                      'Ingrese las dificultades',
                      'Aca puede agregar los dificultades que obtuvo el proyecto..',
                      false,
                      (texto){
                        setState(() {
                          txtDificultad = texto;
                        });
                      },
                      controllerDificultad
                    ),
                    GestureDetector(
                      onTap: (){
                        anadirLogroDificultad();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:10.0),
                        // color: AppTheme.bottomPrincipal,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only( 
                              topLeft:     Radius.circular(10.0),
                              topRight:    Radius.circular(10.0),
                              bottomLeft:  Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppTheme.primero,
                                AppTheme.segundo,
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
                                        fontFamily: 'montserrat',
                                        fontSize: 12,
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
                    
                    for(int cont=0; cont<listaLogrosDificultades.length; cont++)
                    bloqueAgregado(
                      context, 
                      listaLogrosDificultades[cont]['titulo'], 
                      listaLogrosDificultades[cont]['logro'], 
                      listaLogrosDificultades[cont]['dificultad'], 
                      (){listaLogrosDificultades.removeAt(cont); setState(() {listaLogrosDificultades = listaLogrosDificultades;}); contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'] = listaLogrosDificultades;})
                    
                  ],
                ),
              ),
            ]
          )
        )
      ],
    );
  }

  void anadirLogroDificultad()
  {
    controllerLogro.clear();
    controllerDificultad.clear();
    listaLogrosDificultades.add(
      {
        'aspectoEvaluarId' : idAspectoEvaluar,
        'titulo'      : txtBtnDesplegableAvanceCualitativo,
        'logro'       : txtLogro,
        'dificultad'  : txtDificultad,
      }
    );
    setState(() {
      listaLogrosDificultades = listaLogrosDificultades;
    });
    
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'] = listaLogrosDificultades;
  }
}