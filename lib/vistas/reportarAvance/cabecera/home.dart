import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cabecera/cardHead.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CardHeadReporteAvance extends StatefulWidget {
  final int numeroPaso;
  CardHeadReporteAvance({Key key, this.numeroPaso,}) : super(key: key);
  
  @override
 CardHeadReporteAvanceState createState() => CardHeadReporteAvanceState();

}

class CardHeadReporteAvanceState extends State<CardHeadReporteAvance> {

// class CardHeadReporteAvance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
          width: MediaQuery.of(context).size.width,
          height: 30.0,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/18
          ),
          child: Container(
            margin: EdgeInsets.only(right: 20, left: 20),
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
                      Proyecto()
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.only(left:5.0, top:6.0),
                  child: Text(
                    'Reportar Avance',
                    style: AppTheme.h1Blanco
                  ),
                )
                
              ],
            ),
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/12,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/10, 
            right: 20.0, 
            left: 20.0
          ),
          child: Container(
            child: Row(
              children: <Widget>[ 
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                      top: 5.0,
                      left: 5.0,
                      right: 5.0,
                      bottom: 2.0
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(38, 38, 38, 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: titleColor.withOpacity(.1),
                          blurRadius: 20,
                          spreadRadius: 10
                        ),
                      ]
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.asset(
                              'assets/img/Desglose/Demas/icn-money.png',
                              width: 30.0,
                            ),
                          )
                        ),
                        Padding(
                          padding:EdgeInsets.only(right:10.0)
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '38%',
                                  style: AppTheme.h2Blanco
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  'Valor Proyectado',
                                  style: AppTheme.parrafoBlanco,
                                ),
                              ],
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                      top: 5.0,
                      left: 5.0,
                      right: 5.0,
                      bottom: 2.0
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(38, 38, 38, 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: titleColor.withOpacity(.1),
                          blurRadius: 20,
                          spreadRadius: 10
                        ),
                      ]
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.asset(
                              'assets/img/Desglose/Demas/icn-money.png',
                              width: 30.0,
                            ),
                          )
                        ),
                        Padding(
                          padding:EdgeInsets.only(right:10.0)
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '45%',
                                  style: AppTheme.h2Blanco
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  'Valor Ejecutado',
                                  style: AppTheme.parrafoBlanco,
                                ),
                              ],
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          )
        ),

        pasos(
          context,
          widget.numeroPaso
        )
      ],
    );
  }
}