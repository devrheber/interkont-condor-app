import 'package:appalimentacion/vistas/proyecto/cardTitulo.dart';
import 'package:appalimentacion/vistas/proyecto/cuerpo.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class ContenidoProyecto extends StatefulWidget {
  
  ContenidoProyecto({Key key}) : super(key: key);
  
  @override
  ContenidoProyectoState createState() => ContenidoProyectoState();
}

class ContenidoProyectoState extends State<ContenidoProyecto> {
// class ContenidoProyecto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardTitulo(
        ),
        SizedBox(
          height: 10,
        ),
        CardCuerpo()
      ],
      
    );
  }
}