import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/reportarAvance/reportar_avance_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../../globales/funciones/calcularValorEjecutado.dart';
import '../../../../globales/title_subtitle.dart';
import '../../../../globales/variables.dart';
import 'buscador.dart';
import 'card_carousel_avances.dart';

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

  var proyectos = contenidoWebService[0]['proyectos'];
  List<dynamic> actividades = contenidoWebService[0]['proyectos']
      [posListaProySelec]['datos']['actividades'];
  List<dynamic> actividadesFilter = contenidoWebService[0]['proyectos']
      [posListaProySelec]['datos']['actividades'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
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
                child: buscador(onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      actividadesFilter = actividades;
                    });
                  }
                  txtBuscarAvance = value;
                }, onPressed: () {
                  filter();
                }),
              ),
              SizedBox(height: 26.23.sp),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeCenterPage: true,
                  height: 435.0.h,
                ),
                items: <Widget>[
                  ...actividadesFilter
                      .asMap()
                      .map((cont, e) {
                        return MapEntry(
                          cont,
                          CardCarouselAvances(
                            calcularPorcentajeValorEjecutado: () {},
                            descripcionActividad: e['descripcionActividad'],
                            unidadMedida: e['unidadMedida'],
                            valorUnitario: e['valorUnitario'],
                            cantidadProgramada: e['cantidadProgramada'],
                            valorProgramado: e['valorProgramado'],
                            cantidadEjecutada: e['cantidadEjecutada'],
                            valorEjecutado: e['valorEjecutado'],
                            porcentajeAvance: e['porcentajeAvance'],
                            txtActividadAvance: e['txtActividadAvance'],
                            accion: (value) {
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
                                e['txtActividadAvance'] = value;
                                e['cantidadEjecutada'] =
                                    sumCantidadEjecutadaValue(
                                        actividades, cont, value);
                                e['valorEjecutado'] =
                                    multCantidadEjecutadaValorUnitario(
                                        actividades, cont);
                                e['porcentajeAvance'] =
                                    calcPorcentajeAvanzado(actividades, cont);
                                calcularValorEjecutado();
                              }
                            },
                          ),
                        );
                      })
                      .values
                      .toList(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void filter() {
    setState(() {
      actividadesFilter = actividades
          .where((element) =>
              element['descripcionActividad']
                  .toLowerCase()
                  .contains(txtBuscarAvance.toLowerCase()) ||
              element['descripcionActividad']
                  .toUpperCase()
                  .contains(txtBuscarAvance.toUpperCase()))
          .toList();
    });
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

class FirstStepBody extends StatefulWidget {
  FirstStepBody({
    Key key,
  }) : super(key: key);

  @override
  FirstStepBodyState createState() => FirstStepBodyState();
}

class FirstStepBodyState extends State<FirstStepBody> {
  // Ingrese cantidad de avance por actividad
  String txtBuscarAvance = '';

  String otros;

  DatosAlimentacion detail;

  @override
  Widget build(BuildContext context) {
    final avanceProvider = Provider.of<ReportarAvanceProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
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
                child: buscador(onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      // actividadesFilter = actividades;
                    });
                  }
                  txtBuscarAvance = value;
                }, onPressed: () {
                  // TODO
                  // filter();
                }),
              ),
              SizedBox(height: 26.23.sp),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeCenterPage: true,
                  height: 435.0.h,
                ),
                items: <Widget>[
                  for (final activity in avanceProvider.detail.actividades)
                    CardCarouselAvancesForm(
                      activity: activity,
                      valueSaved: '0',
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
