import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

class FondoHome extends StatefulWidget {

  final Widget contenido;
  final bool bottomNavigationBar;
  final Widget contenidoBottom;

  FondoHome({
    Key key,
    this.contenido,
    this.bottomNavigationBar,
    this.contenidoBottom
  }) : super(
    key: key
  );

  @override
  FondoHomeState createState() => FondoHomeState();
}

class FondoHomeState extends State<FondoHome> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppTheme.celeste,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:  Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      AppTheme.primero,
                      AppTheme.segundo,
                      
                      // Colors.red,
                      // Colors.black

                    ],
                  ),
                ),
            ),
            widget.contenido  
          ],
        ),
        bottomNavigationBar: 
        widget.bottomNavigationBar == true
        ?widget.contenidoBottom
        :null
      ),
    );
  }
}