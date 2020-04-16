import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/buscador.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/carouselAvances.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class CardCuerpoPrimerPaso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.6 , left: 20.0, right: 20.0),
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
                        fontSize: 17,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Ingrese cantidad de avance por actividad',
                      style: AppTheme.parrafo
                    ),
                  ],
                ),
              ),


              buscador(context),
              
              SizedBox(
                height: 10.0,
              ),


              carouselAvances(context)
            ]
          )
        )
      ],
    );
  }
}