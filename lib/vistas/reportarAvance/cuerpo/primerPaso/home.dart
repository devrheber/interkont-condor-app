import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/buscador.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/carouselAvances.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class CardCuerpoPrimerPaso extends StatefulWidget {
  
  CardCuerpoPrimerPaso({Key key}) : super(key: key);
  
  @override
  CardCuerpoPrimerPasoState createState() => CardCuerpoPrimerPasoState();
}

class CardCuerpoPrimerPasoState extends State<CardCuerpoPrimerPaso> {
  // Ingrese cantidad de avance por actividad
  String txtBuscarAvance = '';

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
                      'Ingrese el avance',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 17,
                        color: Color(0xFF334660),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Ingrese cantidad de avance por actividad',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 13,
                        color: Color(0xFF505050),
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),

              buscador(
                context,
                (value){
                  setState(() {
                    txtBuscarAvance = value;
                  });
                }
              ),
              
              SizedBox(
                height: 10.0,
              ),

              CarouselAvances(
                txtBuscar: txtBuscarAvance,
              )
            ]
          )
        )
      ],
    );
  }
}