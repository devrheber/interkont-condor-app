import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/ui/reportarAvance/reportar_avance_provider.dart';
import 'package:appalimentacion/ui/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../globales/colores.dart';
import '../../globales/funciones/cambiarPasoProyecto.dart';
import '../../globales/funciones/obtenerDatosProyecto.dart';
import '../../globales/transicion.dart';
import '../../globales/variables.dart';
import '../listaProyectos/home.dart';
import 'contenido.dart';
import 'cuerpo/cargando.dart';
import 'cuerpo/factorAtraso/index.dart';

class ReportarAvance extends StatefulWidget {
  ReportarAvance._();

  @override
  ReportarAvanceState createState() => ReportarAvanceState();
}

class ReportarAvanceState extends State<ReportarAvance> {
  SharedPreferences prefs;
  String txtPrimerBoton = '';
  String txtSegundoBoton = '';
  var accionPrimerBoton = () {};
  var accionSegundoBoton = () {};
  int numeroPaso = 0;

  void obtenerVariablesSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    actualizarPaso(
        contenidoWebService[0]['proyectos'][posListaProySelec]['paso']);
    print(numeroPaso);
  }

  @override
  void initState() {
    // print(numeroPaso);
    super.initState();
    obtenerVariablesSharedPreferences();
    // if (keyboardVisibilitySubscriberId3 == null) {
    //   print('escuchar teclado ');
    //   keyboardVisibilitySubscriberId3 = _keyboardVisibility.addNewListener(
    //     onChange: (bool visible) {
    //       if (numeroPaso == 4 || numeroPaso == 1) {
    //         if (visible == false) {
    //           print('$visible');
    //           setState(() {});
    //         }
    //       }
    //     },
    //   );
    // } else if (keyboardVisibilitySubscriberId3 != null) {
    //   _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId3);
    //   keyboardVisibilitySubscriberId3 = _keyboardVisibility.addNewListener(
    //     onChange: (bool visible) {
    //       if (numeroPaso == 4 || numeroPaso == 1) {
    //         if (visible == false) {
    //           print('$visible');
    //           setState(() {});
    //         }
    //       }
    //     },
    //   );
    // }
  }

  void siguiente() async {
    bool checkPhoto = true;
    if (contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                ['fileFotoPrincipal'] ==
            '' ||
        contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                ['fileFotoPrincipal'] ==
            null) {
      checkPhoto = false;
    }
    if (contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                ['porcentajeValorEjecutado']
            .round() >
        100) {
      Toast.show(
          "Lo sentimos, el valor ejecutado debe estar por debajo al 100%",
          context,
          duration: 5,
          gravity: Toast.BOTTOM);
    } else if (boolestSegundoBtnreportarAvance == true && numeroPaso == 4) {
    } else if (numeroPaso == 4 && !checkPhoto) {
      Toast.show("Es necesario una foto principal", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      actualizarPaso(numeroPaso + 1);
      setState(() {
        boolestSegundoBtnreportarAvance = false;
      });
      cambiarPasoProyecto(numeroPaso + 1);
      print(numeroPaso);
      if (contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                  ['txtComentario'] ==
              null &&
          numeroPaso == 4) {
        print('bool_estSegundoBtn_reportarAvance');
        setState(() {
          boolestSegundoBtnreportarAvance = true;
        });
      } else if (contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                  ['txtComentario'] !=
              null &&
          numeroPaso == 4 &&
          contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                      ['txtComentario']
                  .length <
              1) {
        print('bool_estSegundoBtn_reportarAvance');
        setState(() {
          boolestSegundoBtnreportarAvance = true;
        });
      }
    }
    setState(() {});
  }

  void anterior() async {
    setState(() {
      boolestSegundoBtnreportarAvance = false;
    });
    actualizarPaso(numeroPaso - 1);
    cambiarPasoProyecto(numeroPaso - 1);
  }

  void actualizarPaso(int numeroPasoActualizado) {
    setState(() {
      // numeroPaso = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'];
      numeroPaso = numeroPasoActualizado;
      if (numeroPaso == 1) {
        txtPrimerBoton = 'Cancelar';
        txtSegundoBoton = 'Siguiente Paso';
        accionPrimerBoton = () {
          obtenerDatosProyecto(
              contenidoWebService[0]['proyectos'][posListaProySelec]
                  ['codigoproyecto'],
              false);
          Toast.show("El avance ha sido cancelado", context,
              duration: 5, gravity: Toast.BOTTOM);
          cambiarPagina(context, ListaProyectos());
          setState(() {
            boolestSegundoBtnreportarAvance = false;
          });
          actualizarPaso(0);
          cambiarPasoProyecto(0);
        };
        accionSegundoBoton = () {
          siguiente();
        };
      } else if (numeroPaso == 2) {
        txtPrimerBoton = 'Cancelar';
        txtSegundoBoton = 'Siguiente Paso';
        accionPrimerBoton = () {
          anterior();
        };
        accionSegundoBoton = () {
          if (((contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                              ['porcentajeValorProyectadoSeleccionado'] /
                          contenidoWebService[0]['proyectos'][posListaProySelec]
                              ['datos']['porcentajeValorEjecutado']) *
                      100) -
                  100 >
              contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
                  ['limitePorcentajeAtraso']) {
            cambiarPasoProyecto(2);
            cambiarPagina(context, IndexFactorAtraso());
          } else {
            siguiente();
          }
          // print('Siguiente');
        };
      } else if (numeroPaso == 3 || numeroPaso == 4) {
        txtPrimerBoton = 'Cancelar';
        txtSegundoBoton = 'Siguiente Paso';
        accionPrimerBoton = () {
          anterior();
        };
        accionSegundoBoton = () {
          siguiente();
        };
      } else if (numeroPaso >= 5) {
        txtPrimerBoton = 'Cancelar';
        txtSegundoBoton = 'Finalizar';
        accionPrimerBoton = () {
          anterior();
        };
        accionSegundoBoton = () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CargandoFinalizar()),
          );
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FondoHome(
        contenido: ContenidoReportarAvance(numeroPaso: numeroPaso),
        bottomNavigationBar: true,
        contenidoBottom: contenidoBottom(
            context: context,
            colorFondo: AppTheme.bottomPrincipal,
            dosBotones: true,
            primerBotonDesactivado: false,
            segundoBotonDesactivado: boolestSegundoBtnreportarAvance,
            txtPrimerBoton: "$txtPrimerBoton",
            txtSegundoBoton: "$txtSegundoBoton",
            accionPrimerBoton: accionPrimerBoton,
            accionSegundoBoton: accionSegundoBoton));
  }
}

class ReportarAvanceScreen extends StatelessWidget {
  const ReportarAvanceScreen._();

  static Widget init({
    @required Project project,
    @required DatosAlimentacion detail,
    @required ProjectCache cache,
  }) =>
      ChangeNotifierProvider(
        create: (context) => ReportarAvanceProvider(
          project: project,
          detail: detail,
          cache: cache,
          projectsCacheRepository: context.read(),
        ),
        child: ReportarAvanceScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final avancesProvider = Provider.of<ReportarAvanceProvider>(context);
    final projectsProvider = Provider.of<ProjectsProvider>(context);
    final numeroPaso = projectsProvider
        .cache[avancesProvider.project.codigoproyecto.toString()].stepNumber;

    return FondoHome(
      contenido: ContenidoReportarAvance(numeroPaso: numeroPaso),
      bottomNavigationBar: true,
      contenidoBottom: contenidoBottom(
        context: context,
        colorFondo: AppTheme.bottomPrincipal,
        dosBotones: true,
        primerBotonDesactivado: false,
        segundoBotonDesactivado: boolestSegundoBtnreportarAvance,
        txtPrimerBoton: 'Cancelar',
        txtSegundoBoton: numeroPaso >= 5 ? 'Finalizar' : 'Siguiente Paso',
        accionPrimerBoton: () {
          if (numeroPaso != 1) {
            // Paso Anterior
            avancesProvider.changeAndSaveStep(numeroPaso - 1);
            return;
          }

          // TODO Obtener datos de proyecto
          Toast.show("El avance ha sido cancelado", context,
              duration: 5, gravity: Toast.BOTTOM);
          Navigator.pop(context);
          // TODO boolestSegundoBtnreportarAvance
          // TODO update paso
        },
        // TODO
        accionSegundoBoton: () {
          if (numeroPaso == 2) {
            // TODO Show FactorAtraso
          }

          if (numeroPaso >= 5) {
            // TODO Navegar a CargandoFinalizar
          }
          avancesProvider.changeAndSaveStep(numeroPaso + 1);
        },
      ),
    );
  }
}
