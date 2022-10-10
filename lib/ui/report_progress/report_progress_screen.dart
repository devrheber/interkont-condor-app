import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
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

class ReportProgressScreen extends StatelessWidget {
  const ReportProgressScreen._();

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
        child: ReportProgressScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final avancesProvider = Provider.of<ReportarAvanceProvider>(context);
    final projectsProvider = Provider.of<ProjectsProvider>(context);
    final numeroPaso = projectsProvider
        .cache[avancesProvider.project.codigoproyecto.toString()].stepNumber;

    return FondoHome(
      body: ContenidoReportarAvance(numeroPaso: numeroPaso),
      bottomNavigationBar: CustomBottomNavigationBar(
        colorFondo: AppTheme.bottomPrincipal,
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

class ReportarAvance extends StatefulWidget {
  ReportarAvance._();

  @override
  ReportarAvanceState createState() => ReportarAvanceState();
}

class ReportarAvanceState extends State<ReportarAvance> {
  SharedPreferences prefs;
  String txtPrimerBoton = 'Cancelar';
  String txtSegundoBoton = 'Siguiente Paso';
  var accionPrimerBoton = () {};
  var accionSegundoBoton = () {};
  int numeroPaso = 0;

  @override
  void initState() {
    super.initState();
    // TODO update step

    if (numeroPaso >= 5) {
      txtSegundoBoton = 'Finalizar';
    }
  }

  // Temp
  final project = {};

  void siguiente() async {
    bool checkPhoto = true;
    if (project['datos']['fileFotoPrincipal'] == '' ||
        project['datos']['fileFotoPrincipal'] == null) {
      checkPhoto = false;
    }

    if (project['datos']['porcentajeValorEjecutado'].round() > 100) {
      Toast.show(
          "Lo sentimos, el valor ejecutado debe estar por debajo al 100%",
          context,
          duration: 5,
          gravity: Toast.BOTTOM);
    } else if (boolestSegundoBtnreportarAvance == true && numeroPaso == 4) {
      // Nothing
    } else if (numeroPaso == 4 && !checkPhoto) {
      Toast.show("Es necesario una foto principal", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      actualizarPaso(numeroPaso + 1);

      boolestSegundoBtnreportarAvance = false;

      cambiarPasoProyecto(numeroPaso + 1);
      if (project['datos']['txtComentario'] == null && numeroPaso == 4) {
        boolestSegundoBtnreportarAvance = true;
      } else if (project['datos']['txtComentario'] != null &&
          numeroPaso == 4 &&
          project['datos']['txtComentario'].length < 1) {
        boolestSegundoBtnreportarAvance = true;
      }
    }
  }

  void anterior() async {
    boolestSegundoBtnreportarAvance = false;
    actualizarPaso(numeroPaso - 1);
    cambiarPasoProyecto(numeroPaso - 1);
  }

  void actualizarPaso(int numeroPasoActualizado) {
    numeroPaso = numeroPasoActualizado;
    if (numeroPaso == 1) {
      accionPrimerBoton = () {
        obtenerDatosProyecto(project['codigoproyecto'], false);
        Toast.show("El avance ha sido cancelado", context,
            duration: 5, gravity: Toast.BOTTOM);
        cambiarPagina(context, ListaProyectos());
        setState(() {
          boolestSegundoBtnreportarAvance = false;
        });
        actualizarPaso(0);
        cambiarPasoProyecto(0);
      };
      accionSegundoBoton = () => siguiente();
    } else if (numeroPaso == 2) {
      accionPrimerBoton = () {
        anterior();
      };
      accionSegundoBoton = () {
        if (((project['datos']['porcentajeValorProyectadoSeleccionado'] /
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
      };
    } else if (numeroPaso == 3 || numeroPaso == 4) {
      accionPrimerBoton = () {
        anterior();
      };
      accionSegundoBoton = () {
        siguiente();
      };
    } else if (numeroPaso >= 5) {
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
  }

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      body: ContenidoReportarAvance(numeroPaso: numeroPaso),
      bottomNavigationBar: CustomBottomNavigationBar(
        colorFondo: AppTheme.bottomPrincipal,
        primerBotonDesactivado: false,
        segundoBotonDesactivado: boolestSegundoBtnreportarAvance,
        txtPrimerBoton: "$txtPrimerBoton",
        txtSegundoBoton: "$txtSegundoBoton",
        accionPrimerBoton: accionPrimerBoton,
        accionSegundoBoton: accionSegundoBoton,
      ),
    );
  }
}
