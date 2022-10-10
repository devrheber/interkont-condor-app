import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/add_green_button.dart';
import '../../../../globales/colores.dart';
import '../../../../globales/customed_app_bar.dart';
import '../../../../globales/funciones/cambiarPasoProyecto.dart';
import '../../../../globales/variables.dart';
import '../../../../theme/color_theme.dart';
import 'widgets/campoSeleecionar.dart';
import 'widgets/factorRegistrado.dart';

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

  TextEditingController descripcionAtraso = TextEditingController();

  registrarFactor() {
    if (idTipoFactorAtrasoSeleccionado != 0 &&
        idFactorAtrasoSeleccionado != 0) {
      setState(() {
        bool_avanzarSiguientePaso = false;
        listaFactoresRegistrados.add({
          'tipoFactorAtrasoId': idTipoFactorAtrasoSeleccionado,
          'tipoFactor': '$tipoFactorSeleccionado',
          'factorAtrasoId': idFactorAtrasoSeleccionado,
          'factor': '$factorSeleccionado',
          'descripcion': '${descripcionAtraso.text}',
        });
      });
      contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
          ['factoresAtrasoSeleccionados'] = listaFactoresRegistrados;
      descripcionAtraso.clear();
    }
  }

  @override
  void initState() {
    if (contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['factoresAtrasoSeleccionados'] !=
        null) {
      setState(() {
        listaFactoresRegistrados = contenidoWebService[0]['proyectos']
            [posListaProySelec]['datos']['factoresAtrasoSeleccionados'];
        if (listaFactoresRegistrados.length > 0) {
          bool_avanzarSiguientePaso = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                // TODO
                // cambiarPagina(context, ReportarAvance());
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 28.sp),
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
                        contenidoWebService[0]['proyectos'][posListaProySelec]
                            ['datos']['tiposFactorAtraso'], (nuevaPosicion) {
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        tipoFactorSeleccionado = contenidoWebService[0]
                                    ['proyectos'][posListaProySelec]['datos']
                                ['tiposFactorAtraso'][nuevaPosicion]
                            ['tipoFactorAtraso'];
                        idTipoFactorAtrasoSeleccionado = contenidoWebService[0]
                                    ['proyectos'][posListaProySelec]['datos']
                                ['tiposFactorAtraso'][nuevaPosicion]
                            ['tipoFactorAtrasoId'];
                      });
                    }),
                    campoSeleccionar(
                        '$factorSeleccionado',
                        'factorAtraso',
                        posicionPeriodoReportado,
                        idTipoFactorAtrasoSeleccionado,
                        true,
                        contenidoWebService[0]['proyectos'][posListaProySelec]
                            ['datos']['factoresAtraso'], (nuevaPosicion) {
                      setState(() {
                        posicionPeriodoReportado = nuevaPosicion;
                        factorSeleccionado = contenidoWebService[0]['proyectos']
                                [posListaProySelec]['datos']['factoresAtraso']
                            [nuevaPosicion]['factorAtraso'];
                        idFactorAtrasoSeleccionado = contenidoWebService[0]
                                ['proyectos'][posListaProySelec]['datos']
                            ['factoresAtraso'][nuevaPosicion]['factorAtrasoId'];
                      });
                    }),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      // margin: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(1, 1, 1, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.send,
                        controller: descripcionAtraso,
                        // onChanged: accion,
                        maxLines: 4,
                        maxLength: 500,

                        style: AppTheme.parrafoBlanco,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterStyle: AppTheme.parrafoBlanco,
                          border: InputBorder.none,
                          hintText:
                              "Ingrese una descripción del factor de atraso",
                          hintStyle: AppTheme.parrafoBlanco,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    AddGreenButton(onTap: () {
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
                            return FactorRegistrado(
                              posicion: cont,
                              tipo: listaFactoresRegistrados[cont]
                                  ['tipoFactor'],
                              factor: listaFactoresRegistrados[cont]['factor'],
                              description: listaFactoresRegistrados[cont]
                                  ['descripcion'],
                              onTap: () {
                                listaFactoresRegistrados.removeAt(cont);
                                setState(() {
                                  listaFactoresRegistrados =
                                      listaFactoresRegistrados;
                                  if (listaFactoresRegistrados.length == 0) {
                                    bool_avanzarSiguientePaso = true;
                                  }
                                });
                                contenidoWebService[0]['proyectos']
                                            [posListaProySelec]['datos']
                                        ['factoresAtrasoSeleccionados'] =
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
            CustomBottomNavigationBar(
              colorFondo: Color(0xFF2089B6),
              primerBotonDesactivado: false,
              segundoBotonDesactivado: bool_avanzarSiguientePaso,
              txtPrimerBoton: "Cancelar",
              txtSegundoBoton: "Siguiente Paso",
              accionPrimerBoton: () {
                cambiarPasoProyecto(2);
                // TODO
                // cambiarPagina(context, ReportarAvance());
              },
              accionSegundoBoton: () {
                if (bool_avanzarSiguientePaso == false) {
                  cambiarPasoProyecto(3);
                  // TODO
                  // cambiarPagina(context, ReportarAvance());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
