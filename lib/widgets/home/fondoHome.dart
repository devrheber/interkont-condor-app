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
              height: MediaQuery.of(context).size.height/3,
              // decoration: BoxDecoration(
                
                // gradient: LinearGradient(colors: [AppTheme.primero, AppTheme.segundo, AppTheme.tercero])
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:  Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      AppTheme.primero,
                      AppTheme.segundo,
                      AppTheme.tercero,
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