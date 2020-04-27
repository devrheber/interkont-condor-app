import 'package:appalimentacion/vistas/reportarAvance/cuerpo/quintoPaso/cardContenido.dart';
import 'package:flutter/material.dart';

class CardCuerpoQuintoPaso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/5.6, 
            left: 20.0, 
            right: 20.0
          ),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              cardContenidoQuintoPaso(context, 'Antes'),
              
              SizedBox(
                height: 10.0,
              ),

              cardContenidoQuintoPaso(context, 'Ahora'),
              
            ]
          )
        )
      ],
    );
  }
}