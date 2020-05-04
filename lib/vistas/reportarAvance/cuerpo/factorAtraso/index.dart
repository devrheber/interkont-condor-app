import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/cambiarPasoProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/widgets/campoSeleecionar.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/widgets/factorRegistrado.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexFactorAtraso extends StatefulWidget {
  
  IndexFactorAtraso({Key key}) : super(key: key);
  
  @override
  IndexFactorAtrasoState createState() => IndexFactorAtrasoState();
}

class IndexFactorAtrasoState extends State<IndexFactorAtraso> {

  // Factores Registrados
  int posicionPeriodoReportado = 0;
  int idTipoFactorAtrasoSeleccionado = 0;
  int idFactorAtrasoSeleccionado = 0;
  String tipoFactorSeleccionado = 'Selecciona el tipo de factor';
  String factorSeleccionado = 'Selecciona el factor';
  List listaFactoresRegistrados = [];

  registrarFactor()
  {
    if(idTipoFactorAtrasoSeleccionado != 0 && idFactorAtrasoSeleccionado != 0 ){
      setState(() {
        listaFactoresRegistrados.add({
            'tipoFactorAtrasoId' : idTipoFactorAtrasoSeleccionado,
            'tipoFactor'   : '$tipoFactorSeleccionado',
            'factorAtrasoId' : idFactorAtrasoSeleccionado,
            'factor'       : '$factorSeleccionado'
          });
      });
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'] = listaFactoresRegistrados;
    }
  }

  @override
  void initState()
  {
    if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'] != null){
      setState(() {
        listaFactoresRegistrados = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Color(0xff0c81ab),
              Color(0xff2eac78)
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: MediaQuery.of(context).size.height/10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ), 
                    onPressed: (){
                      cambiarPasoProyecto(
                        2
                      );
                      cambiarPagina(
                        context, 
                        ReportarAvance()
                      );
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 10.0
                    ),
                    child: Text(
                      'Stop! Este proyecto \npresenta factores de atraso.',
                      style: AppTheme.h1Blanco,
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0
                    ),
                    child: Text(
                      'Ingresa los factores de atraso',
                      style: AppTheme.parrafoBlancoNegrita,
                    )
                  ),

                  campoSeleccionar(
                    '$tipoFactorSeleccionado',
                    'tipoFactorAtraso',
                    posicionPeriodoReportado,
                    idTipoFactorAtrasoSeleccionado,
                    false,
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['tiposFactorAtraso'],
                    (nuevaPosicion){
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        tipoFactorSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['tiposFactorAtraso'][nuevaPosicion]['tipoFactorAtraso'];
                        idTipoFactorAtrasoSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['tiposFactorAtraso'][nuevaPosicion]['tipoFactorAtrasoId'];
                      });
                    }
                  ),

                  campoSeleccionar(
                    '$factorSeleccionado',
                    'factorAtraso',
                    posicionPeriodoReportado,
                    idTipoFactorAtrasoSeleccionado,
                    true,
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtraso'],
                    (nuevaPosicion){
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        factorSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtraso'][nuevaPosicion]['factorAtraso'];
                        idFactorAtrasoSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtraso'][nuevaPosicion]['factorAtrasoId'];
                      });
                    }
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      bottom: 30.0
                    ),
                    margin: EdgeInsets.only(
                      bottom: 10.0
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: Colors.white
                        )
                      )
                    ),
                    child: GestureDetector(
                      onTap: (){
                        registrarFactor();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only( 
                            topLeft:     Radius.circular(10.0),
                            topRight:    Radius.circular(10.0),
                            bottomLeft:  Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 0.01
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: <Color>[
                              AppTheme.dieciochoavo,
                              AppTheme.tercero
                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(top:5.0, left:5.0),
                        padding: EdgeInsets.only(left:20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                FontAwesomeIcons.plusCircle,
                                color: Colors.white,
                                size: 17.0
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.0
                              ),
                              child: Text(
                                'Añadir',
                                style: AppTheme.parrafoBlancoNegrita,
                                textAlign: TextAlign.center,
                              )
                            )
                          ],
                        )
                      ),
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0
                    ),
                    child: Text(
                      'Factores Registrados',
                      style: AppTheme.parrafoBlancoNegrita,
                    ),
                  ),

                  for(int cont= 0; cont < listaFactoresRegistrados.length; cont++)
                  factorRegistrado(
                    cont,
                    listaFactoresRegistrados[cont]['tipoFactor'],
                    listaFactoresRegistrados[cont]['factor'],
                    (){
                      listaFactoresRegistrados.removeAt(cont); setState(() {listaFactoresRegistrados = listaFactoresRegistrados;});
                      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'] = listaFactoresRegistrados;
                    }
                  ),
                ],
              ),
            ),
          ],
        )
      ),

      bottomNavigationBar: contenidoBottom(
        context,
        Color(0xFF2089B6),
        true,
        false,
        false,
        "Cancelar",
        "Siguiente Paso",
        (){
          cambiarPasoProyecto(
            2
          );
          cambiarPagina(
            context, 
            ReportarAvance()
          );
        },
        (){
          cambiarPasoProyecto(
            3
          );
          cambiarPagina(
            context, 
            ReportarAvance()
          );
        }
      ),
    );
  }
}