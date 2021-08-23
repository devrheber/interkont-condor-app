import 'package:appalimentacion/globales/add_button_green.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/custemed_app_bar.dart';
import 'package:appalimentacion/globales/funciones/cambiarPasoProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/widgets/campoSeleecionar.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/factorAtraso/widgets/factorRegistrado.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:appalimentacion/widgets/home/contenidoBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexFactorAtraso extends StatefulWidget {
  IndexFactorAtraso({Key key}) : super(key: key);

  @override
  IndexFactorAtrasoState createState() => IndexFactorAtrasoState();
}

class IndexFactorAtrasoState extends State<IndexFactorAtraso> {
  // Factores Registrados
  int posicionPeriodoReportado = 0;
  int idTipoFactorAtrasoSeleccionado = 0;
  int idFactorAtrasoSeleccionado = 0;
  String tipoFactorSeleccionado = 'Selecciona el tipo de factor';
  String factorSeleccionado = 'Selecciona el factor';
  List listaFactoresRegistrados = [];
  bool bool_avanzarSiguientePaso = true;

  registrarFactor() {
    if (idTipoFactorAtrasoSeleccionado != 0 &&
        idFactorAtrasoSeleccionado != 0) {
      setState(() {
        bool_avanzarSiguientePaso = false;
        listaFactoresRegistrados.add({
          'tipoFactorAtrasoId': idTipoFactorAtrasoSeleccionado,
          'tipoFactor': '$tipoFactorSeleccionado',
          'factorAtrasoId': idFactorAtrasoSeleccionado,
          'factor': '$factorSeleccionado'
        });
      });
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
          ['datos']['factoresAtrasoSeleccionados'] = listaFactoresRegistrados;
    }
  }

  @override
  void initState() {
    if (contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['factoresAtrasoSeleccionados'] !=
        null) {
      setState(() {
        listaFactoresRegistrados = contenidoWebService[0]['proyectos']
                [posicionListaProyectosSeleccionado]['datos']
            ['factoresAtrasoSeleccionados'];
        if (listaFactoresRegistrados.length > 0) {
          bool_avanzarSiguientePaso = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            customedAppBar(
              title: '',
              onPressed: () {
                cambiarPasoProyecto(2);
                cambiarPagina(context, ReportarAvance());
              },
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 28.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/img/Desglose/ReporteAvance/icn-stop.png',
                      width: 45,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0.sp, bottom: 10.0.sp),
                        child: Text(
                          'Stop! Este proyecto \npresenta factores de atraso.',
                          style: AppTheme.h1Blanco,
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0.sp),
                        child: Text(
                          'Ingresa los factores de atraso',
                          style: AppTheme.parrafoBlancoNegrita,
                        )),
                    campoSeleccionar(
                        '$tipoFactorSeleccionado',
                        'tipoFactorAtraso',
                        posicionPeriodoReportado,
                        idTipoFactorAtrasoSeleccionado,
                        false,
                        contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]['datos']
                            ['tiposFactorAtraso'], (nuevaPosicion) {
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        tipoFactorSeleccionado = contenidoWebService[0]
                                        ['proyectos']
                                    [posicionListaProyectosSeleccionado]
                                ['datos']['tiposFactorAtraso'][nuevaPosicion]
                            ['tipoFactorAtraso'];
                        idTipoFactorAtrasoSeleccionado = contenidoWebService[0]
                                        ['proyectos']
                                    [posicionListaProyectosSeleccionado]
                                ['datos']['tiposFactorAtraso'][nuevaPosicion]
                            ['tipoFactorAtrasoId'];
                      });
                    }),
                    campoSeleccionar(
                        '$factorSeleccionado',
                        'factorAtraso',
                        posicionPeriodoReportado,
                        idTipoFactorAtrasoSeleccionado,
                        true,
                        contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]['datos']
                            ['factoresAtraso'], (nuevaPosicion) {
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        factorSeleccionado = contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]['datos']
                            ['factoresAtraso'][nuevaPosicion]['factorAtraso'];
                        idFactorAtrasoSeleccionado = contenidoWebService[0]
                                    ['proyectos']
                                [posicionListaProyectosSeleccionado]['datos']
                            ['factoresAtraso'][nuevaPosicion]['factorAtrasoId'];
                      });
                    }),
                    SizedBox(height: 10.h),
                    buildAddGreenButton(onTap: () {
                      registrarFactor();
                    }),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0.sp),
                      child: Text(
                        'Factores Registrados',
                        style: AppTheme.parrafoBlancoNegrita,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listaFactoresRegistrados.length,
                          itemBuilder: (BuildContext context, int cont) {
                            return factorRegistrado(
                              cont,
                              listaFactoresRegistrados[cont]['tipoFactor'],
                              listaFactoresRegistrados[cont]['factor'],
                              () {
                                listaFactoresRegistrados.removeAt(cont);
                                setState(() {
                                  listaFactoresRegistrados =
                                      listaFactoresRegistrados;
                                  if (listaFactoresRegistrados.length == 0) {
                                    bool_avanzarSiguientePaso = true;
                                  }
                                });
                                contenidoWebService[0]['proyectos']
                                            [posicionListaProyectosSeleccionado]
                                        [
                                        'datos']['factoresAtrasoSeleccionados'] =
                                    listaFactoresRegistrados;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            contenidoBottom(
              context: context,
              colorFondo: Color(0xFF2089B6),
              dosBotones: true,
              primerBotonDesactivado: false,
              segundoBotonDesactivado: bool_avanzarSiguientePaso,
              txtPrimerBoton: "Cancelar",
              txtSegundoBoton: "Siguiente Paso",
              accionPrimerBoton: () {
                cambiarPasoProyecto(2);
                cambiarPagina(context, ReportarAvance());
              },
              accionSegundoBoton: () {
                if (bool_avanzarSiguientePaso == false) {
                  cambiarPasoProyecto(3);
                  cambiarPagina(context, ReportarAvance());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
