import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/tercerPaso/carouselAvances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

final titleColor = Color(0xff444444);

class CardCuerpoTercerPaso extends StatefulWidget {
  
  CardCuerpoTercerPaso({Key key}) : super(key: key);
  
  @override
  CardCuerpoTercerPasoState createState() => CardCuerpoTercerPasoState();
}

class CardCuerpoTercerPasoState extends State<CardCuerpoTercerPaso> {
// class CardCuerpoTercerPaso extends StatelessWidget {
  // Indicador de alcance
  String txtBuscarAlcance = '';

  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  @protected
  void initState() {
    super.initState();

    if(keyboardVisibilitySubscriberId2 == null){
      print('escuchar teclado ');
      keyboardVisibilitySubscriberId2 = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if(visible == false){
            print('ejecutar');
            print('$visible');
            setState(() {
              
            });
          }
        },
      );
    }else{
      _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId2);
      keyboardVisibilitySubscriberId2 = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if(visible == false){
            print('ejecutar');
            print('$visible');
            setState(() {
              
            });
          }
        },
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/3.5
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 20.0, 
                        right: 20.0
                      ),
                      padding: EdgeInsets.only(right: 5.0, left:5.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Indicador de alcance',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 17,
                              color: Color(0xFF334660),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Ingrese indicadores de alcance en el periodo',
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
                    SizedBox(
                      height: 10.0,
                    ),
                    CarouselSlider(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height: 260.0,
                      items: <Widget>[
                        for(int cont=0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'].length; cont++)
                        cardCarousel(
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['descripcionIndicadorAlcance'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['unidadMedida'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadProgramada'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutada'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['porcentajeAvance'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'],
                          (value){
                            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'] = value;
                            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutada'] = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutadaInicial']}') + double.parse('$value');
                            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['porcentajeAvance'] = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutada']}') / double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadProgramada']}');
                          }
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]
          )
        )
      ],
    );
  }
}