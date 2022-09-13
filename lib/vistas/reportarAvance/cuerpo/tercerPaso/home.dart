import 'package:appalimentacion/globales/title_subtitle.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/tercerPaso/card_carousel_avances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:toast/toast.dart';

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

  //KeyboardVisibilityNotification _keyboardVisibility =
        //new KeyboardVisibilityNotification();
  @protected
  void initState() {
    super.initState();

    // if (keyboardVisibilitySubscriberId2 == null) {
    //   print('escuchar teclado ');
    //   keyboardVisibilitySubscriberId2 = _keyboardVisibility.addNewListener(
    //     onChange: (bool visible) {
    //       print(visible);
    //       if (visible == false) {
    //         print('ejecutar');
    //         print('$visible');
    //         setState(() {});
    //       }
    //     },
    //   );
    // } else {
    //   _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId2);
    //   keyboardVisibilitySubscriberId2 = _keyboardVisibility.addNewListener(
    //     onChange: (bool visible) {
    //       print(visible);
    //       if (visible == false) {
    //         print('ejecutar');
    //         print('$visible');
    //         setState(() {});
    //       }
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      padding:
                          EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextTitle(text: 'Indicador de alcance'),
                          SizedBox(height: 2.sp),
                          TextSubtitle(
                              text:
                                  'Ingrese indicadores de alcance en el periodo'),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.sp), 
                    CarouselSlider(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height: 350.h,
                      items: <Widget>[ 
                        for (int cont = 0;
                            cont <
                                contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                                        ['datos']['indicadoresAlcance']
                                    .length;
                            cont++)
                          cardCarousel3(
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                                      ['datos']['indicadoresAlcance'][cont]
                                  ['descripcionIndicadorAlcance'],
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                                  ['indicadoresAlcance'][cont]['unidadMedida'],
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                                      ['datos']['indicadoresAlcance'][cont]
                                  ['cantidadProgramada'],
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                                  ['indicadoresAlcance'][cont]['cantidadEjecutada'],
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['porcentajeAvance'],
                              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'], (value) {
                            if (double.parse('$value') < 0) {
                              Toast.show(
                                  "Lo sentimos, solo aceptamos numeros positivos",
                                  context,
                                  duration: 3,
                                  gravity: Toast.BOTTOM);
                            } else {
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['indicadoresAlcance'][cont]
                                  ['txtEjecucionIndicadorAlcance'] = value;
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['indicadoresAlcance'][cont]
                                  ['cantidadEjecutada'] = double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutadaInicial']}') +
                                  double.parse('$value');
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['indicadoresAlcance'][cont]
                                  ['porcentajeAvance'] = double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadEjecutada']}') /
                                  double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['cantidadProgramada']}') *
                                  100;
                            }
                          })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
