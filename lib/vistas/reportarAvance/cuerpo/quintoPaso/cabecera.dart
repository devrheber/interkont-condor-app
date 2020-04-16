import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/cabecera/cardHead.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CardHeadReporteAvanceQuintoPaso extends StatefulWidget {
  final int numeroPaso;
  CardHeadReporteAvanceQuintoPaso({Key key, this.numeroPaso,}) : super(key: key);
  
  @override
 CardHeadReporteAvanceQuintoPasoState createState() => CardHeadReporteAvanceQuintoPasoState();

}

class CardHeadReporteAvanceQuintoPasoState extends State<CardHeadReporteAvanceQuintoPaso> {

// class CardHeadReporteAvanceQuintoPaso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          margin: EdgeInsets.only( top: MediaQuery.of(context).size.height/8,),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // color: Colors.red,
                child: IconButton(
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
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Center(
                // color: Colors.black,
                // margin: EdgeInsets.only(right:20.0),
                // padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '¡Último Paso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'No finalices sin antes estar seguro de',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'tus nuevos cambios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              )
              
            ],
          ),
          
        ),



        
        
      ],
    );
  }
}