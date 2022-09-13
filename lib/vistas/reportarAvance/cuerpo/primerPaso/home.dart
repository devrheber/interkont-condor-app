import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/title_subtitle.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/buscador.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/card_carousel_avances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';
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

  String otros;

  @protected
  void initState() {
    super.initState();
    loadToAvoidNullOperator();
  }

  @override
  Widget build(BuildContext context) {
    var proyectos = contenidoWebService[0]['proyectos'];
    var actividades =
        proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'];
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
                    TextTitle(text: 'Ingrese el avance'),
                    SizedBox(height: 2.sp),
                    TextSubtitle(
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
                  for (int cont = 0; cont < actividades.length; cont++)
                    if (descripcionActividad(actividades, cont))
                      cardCarousel1(
                        () {
                          if (cont == 0) {}
                        },
                        actividades[cont]['descripcionActividad'],
                        actividades[cont]['unidadMedida'],
                        actividades[cont]['valorUnitario'],
                        actividades[cont]['cantidadProgramada'],
                        actividades[cont]['valorProgramado'],
                        actividades[cont]['cantidadEjecutada'],
                        actividades[cont]['valorEjecutado'],
                        actividades[cont]['porcentajeAvance'],
                        actividades[cont]['txtActividadAvance'],
                        (value) {
                          if (double.parse('$value') < 0) {
                            Toast.show(
                              "Lo sentimos, solo aceptamos numeros positivos",
                              context,
                              duration: 3,
                              gravity: Toast.BOTTOM,
                            );
                          } else if (double.parse('$value') > 100) {
                            Toast.show( 
                              "El valor ejecutado de la actividad no puede superar el 100%",
                              context,
                              duration: 3,
                              gravity: Toast.BOTTOM,
                            );
                          } else {
                            print('positivo');
                            actividades[cont]['txtActividadAvance'] = value;
                            actividades[cont]['cantidadEjecutada'] =
                                sumCantidadEjecutadaValue(
                                    actividades, cont, value);
                            actividades[cont]['valorEjecutado'] =
                                multCantidadEjecutadaValorUnitario(
                                    actividades, cont);
                            actividades[cont]['porcentajeAvance'] =
                                calcPorcentajeAvanzado(actividades, cont);
                            calcularValorEjecutado();
                          }
                        },
                      )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  double calcPorcentajeAvanzado(actividades, int cont) {
    return double.parse('${actividades[cont]['valorEjecutado']}') /
        double.parse('${actividades[cont]['valorProgramado']}') *
        100;
  }

  double multCantidadEjecutadaValorUnitario(actividades, int cont) {
    return double.parse('${actividades[cont]['cantidadEjecutada']}') *
        double.parse('${actividades[cont]['valorUnitario']}');
  }

  double sumCantidadEjecutadaValue(actividades, int cont, value) {
    return double.parse('${actividades[cont]['cantidadEjecutadaInicial']}') +
        double.parse('$value');
  }

  bool descripcionActividad(dynamic actividades, int cont) {
    return actividades[cont]['descripcionActividad']
                .indexOf(txtBuscarAvance.toUpperCase()) !=
            -1 ||
        actividades[cont]['descripcionActividad']
                .indexOf(txtBuscarAvance.toLowerCase()) !=
            -1;
  }

  Future<void> loadToAvoidNullOperator() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
}
