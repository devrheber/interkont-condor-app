import 'package:appalimentacion/globales/colores.dart';

import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


final titleColor = Color(0xff444444);

class CardTitulo extends StatefulWidget {
  final int ultimaSincro;
  final activarUltimaSincronizacion;
  CardTitulo({Key key, this.ultimaSincro, this.activarUltimaSincronizacion}) : super(key: key);
  
  @override
  CardTituloState createState() => CardTituloState();
}

class CardTituloState extends State<CardTitulo> {

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/15
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4.5,
                padding: EdgeInsets.only(top: 1.0, bottom: 10.0),
                margin: EdgeInsets.only(top: 40.0,right: 20, left: 20),
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
                  padding: EdgeInsets.only(
                    top:20.0
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left:70.0, 
                          right: 70.0
                        ),
                        child: Text(
                          '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['nombreproyecto']}',
                          textAlign: TextAlign.center,
                          style: AppTheme.tituloParrafo
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),


                      
                      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['ultimaFechaSincro'] == null )
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Últ. sincronización ',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoNegrita
                            ),
                            Image.asset(
                              'assets/img/Desglose/Demas/icn-alert.png',
                              height: 13.0,
                            ),
                            Text(
                              ' Nunca',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoRojoNegrita
                            ),

                          ],
                        )
                      ),

                      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['ultimaFechaSincro'] != null && widget.ultimaSincro == null )
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Últ. sincronización ',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoNegrita
                            ),
                            Text(
                              '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['ultimaFechaSincro']}',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoCelesteNegrita
                            ),
                          ],
                        )
                      ),

                      if(widget.ultimaSincro != null )
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Últ. sincronización ',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoNegrita
                            ),
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: AppTheme.verde,
                              size: 15.0,
                            ),
                            Text(
                              ' Justo Ahora',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoVerdeNegrita
                            ),

                          ],
                        )
                      ),
                      
                      

                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left:30.0, 
                          right: 30.0
                        ),
                        child: Center(
                          child: Text(
                            '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['objeto']}',
                            textAlign: TextAlign.center,
                            style: AppTheme.parrafo
                          ),
                        )
                      )
                    ],
                  )
                )
              ),

              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 75,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: conexionInternet == true
                              ?NetworkImage(
                                '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['imagencategoria']}',
                              )
                              :AssetImage(
                                'assets/img/Desglose/Demas/question.png',
                              ),
                              fit: BoxFit.fitWidth
                            ),
                            border: Border.all(
                              color: Colors.white, 
                              width: 5
                            )
                          ),
                          
                        ),
                      ],
                    )
                  )
                )
              ),


              GestureDetector(
                onTap: widget.activarUltimaSincronizacion,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/3.8
                  ),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55.0),
                              border: Border.all(
                                color: Color(0XFF22ADE2),
                                width: 5
                              ),
                              color: Color(0XFF22ADE2)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.sync,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.0
                                  ),
                                  child: Text(
                                    'Sincronizar',
                                    style: AppTheme.parrafoBlancoNegrita,
                                  ),
                                )
                              ],
                            )
                            
                          ),
                        ],
                      )
                    )
                  )
                ),
              )
            ],    
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 30.0,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/15
          ),
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ), 
                onPressed: (){
                  cambiarPagina(
                    context, 
                    ListaProyectos()
                  );
                }
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/2.2
                )
              ),
              // Column(
              //   children: <Widget>[
              //     Container(
              //       width: 100.0,
              //       height: 30.0,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage(
              //             'assets/img/Desglose/Demas/btn-descargar.png'
              //           ), 
              //           fit: BoxFit.fill
              //         ),
              //         // border: Border(
              //         //   top: BorderSide(width: 0.5, color: Colors.white),
              //         //   left: BorderSide(width: 0.5, color: Colors.white),
              //         //   right: BorderSide(width: 0.5, color: Colors.white),
              //         //   bottom: BorderSide(width: 0.5, color: Colors.white),
              //         // ),
              //         borderRadius: BorderRadius.all( 
              //           Radius.circular(50.0),
              //         ),
              //       ),
              //     )
              //   ],
              // )
              
            ],
          )
        )


      ],
    );
  }
}