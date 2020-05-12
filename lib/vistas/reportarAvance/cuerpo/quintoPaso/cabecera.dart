import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:flutter/material.dart';


class CardHeadReporteAvanceQuintoPaso extends StatefulWidget {
  final int numeroPaso;
  CardHeadReporteAvanceQuintoPaso({Key key, this.numeroPaso,}) : super(key: key);
  
  @override
 CardHeadReporteAvanceQuintoPasoState createState() => CardHeadReporteAvanceQuintoPasoState();

}

class CardHeadReporteAvanceQuintoPasoState extends State<CardHeadReporteAvanceQuintoPaso> {
  
  @protected
  void initState() {
    super.initState();
    calcularValorEjecutado();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/20
          ),
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
                padding: EdgeInsets.all(15.0),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '¡Último Paso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'montserrat',
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
                        fontFamily: 'montserrat',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'tus nuevos cambios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 12,
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