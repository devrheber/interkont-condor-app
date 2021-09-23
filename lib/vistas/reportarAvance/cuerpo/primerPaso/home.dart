import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/title_subtitle.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/buscador.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/card_carousel_avances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:toast/toast.dart';

final titleColor = Color(0xff444444);

class CardCuerpoPrimerPaso extends StatefulWidget {
  CardCuerpoPrimerPaso({Key key}) : super(key: key);

  @override
  CardCuerpoPrimerPasoState createState() => CardCuerpoPrimerPasoState();
}

class CardCuerpoPrimerPasoState extends State<CardCuerpoPrimerPaso> {
  // Ingrese cantidad de avance por actividad
  String txtBuscarAvance = '';
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  String otros;

  @protected
  void initState() {
    super.initState();
    loadToAvoidNullOperator(); 
    if (keyboardVisibilitySubscriberId == null) {
      print('escuchar teclado ');
      keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if (visible == false) {
            print('ejecutar');
            print('$visible');
            setState(() {
              otros = 'asd';
            });
          }
        },
      );
    } else {
      _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId);
      keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if (visible == false) {
            print('ejecutar');
            print('$visible');
            setState(() {
              otros = 'asd';
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
            top: 230.h,
          ),
          // color: Colors.black,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 31.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTextTitle(text: 'Ingrese el avance'),
                    SizedBox(height: 2.sp),
                    buildTextSubtitle(
                        text: 'Ingrese cantidad de avance por actividad'),
                  ],
                ),
              ),
              SizedBox(height: 18.sp),
              Padding(
                padding: EdgeInsets.only(left: 30.0.sp, right: 34.sp),
                child: buscador(
                    onChanged: (value) {
                      txtBuscarAvance = value;
                    },
                    onPressed: () => setState(() {})),
              ),

              SizedBox(height: 26.23.sp),

             CarouselSlider(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height: 435.0.h,
                      items: <Widget>[
                        for (int cont = 0;
                      cont <
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades']
                              .length;
                      cont++)
                    // if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toUpperCase()) != -1 || lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toLowerCase()) != -1  )
                    if (contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['descripcionActividad'].indexOf(txtBuscarAvance.toUpperCase()) != -1 ||
                        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['descripcionActividad'].indexOf(txtBuscarAvance.toLowerCase()) !=
                            -1)
                      cardCarousel1(
                          () {
                            // print(cont);
                            if (cont == 0) {}
                            // contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado']
                          },
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                              ['actividades'][cont]['descripcionActividad'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                              ['datos']['actividades'][cont]['unidadMedida'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                              ['datos']['actividades'][cont]['valorUnitario'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                              ['actividades'][cont]['cantidadProgramada'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                              ['datos']['actividades'][cont]['valorProgramado'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['porcentajeAvance'],
                          contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance'],
                          (value) {
                            if (double.parse('$value') < 0) {
                              Toast.show(
                                  "Lo sentimos, solo aceptamos numeros positivos",
                                  context,
                                  duration: 3,
                                  gravity: Toast.BOTTOM);
                            } else {
                              print('positivo');
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['actividades'][cont]
                                  ['txtActividadAvance'] = value;
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['actividades'][cont]
                                  ['cantidadEjecutada'] = double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutadaInicial']}') +
                                  double.parse('$value');
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['actividades'][cont]
                                  ['valorEjecutado'] = double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada']}') *
                                  double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorUnitario']}');
                              contenidoWebService[0]['proyectos']
                                          [posicionListaProyectosSeleccionado]
                                      ['datos']['actividades'][cont]
                                  ['porcentajeAvance'] = double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado']}') /
                                  double.parse(
                                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorProgramado']}') *
                                  100;
                              calcularValorEjecutado();
                            }
                          })
                      ],
                    ),

              // CarouselAvances(
              //   txtBuscar: txtBuscarAvance,
              // )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadToAvoidNullOperator() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
     
    });
  }
}
