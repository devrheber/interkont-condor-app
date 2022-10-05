import 'package:appalimentacion/app/data/model/datos_alimentacion.dart';
import 'package:appalimentacion/app/data/model/local_project.dart';
import 'package:appalimentacion/app/data/model/project.dart';
import 'package:appalimentacion/vistas/listaProyectos/vista_lista_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../globales/funciones/cambiarPasoProyecto.dart';
import '../../globales/transicion.dart';
import '../../globales/variables.dart';
import '../../widgets/home/contenidoBottom.dart';
import '../../widgets/home/fondoHome.dart';
import '../reportarAvance/home.dart';
import 'contenido.dart';

// class Proyecto extends StatefulWidget {
//   Proyecto({Key key}) : super(key: key);

//   @override
//   ProyectoState createState() => ProyectoState();
// }

// class ProyectoState extends State<Proyecto> {
//   SharedPreferences prefs;
//   void activarVariablesPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//     setState(() {
//       prefs = prefs;
//     });
//   }

//   @override
//   void initState() {
//     activarVariablesPreferences();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FondoHome(
//         contenido: ContenidoProyecto(),
//         bottomNavigationBar: true,
//         // context

//         contenidoBottom: contenidoBottom(
//             context: context,
//             colorFondo: Color(0xff22B573),
//             dosBotones: false,
//             primerBotonDesactivado: false,
//             segundoBotonDesactivado: contenidoWebService[0]['proyectos']
//                 [posListaProySelec]['pendienteAprobacion'],
//             txtPrimerBoton: null,
//             txtSegundoBoton: 'Reportar Avance',
//             accionPrimerBoton: null,
//             accionSegundoBoton: () {
//               if (contenidoWebService[0]['proyectos'][posListaProySelec]
//                       ['pendienteAprobacion'] ==
//                   true) {
//                 // setState(() {
//                 //   segundoBotonDesactivado = false;
//                 // });
//                 Toast.show(
//                     "Lo sentimos, este proyecto esta pendiente de aprobación, sincroniza una vez mas el proyecto, si cree que este ya ha sido aprobado",
//                     context,
//                     duration: 5,
//                     gravity: Toast.BOTTOM);
//               } else if (contenidoWebService[0]['proyectos'][posListaProySelec]
//                       ['datos']['periodoIdSeleccionado'] ==
//                   null) {
//                 Toast.show(
//                     "Lo sentimos, este proyecto no tiene periodos que reportar",
//                     context,
//                     duration: 3,
//                     gravity: Toast.BOTTOM);
//               } else {
//                 // print('Siguiente reportar');
//                 cambiarPasoProyecto(1);
//                 cambiarPagina(context, ReportarAvance());
//               }
//             }));
//   }
// }

class ProyectoScreen extends StatelessWidget {
  ProyectoScreen({Key key, @required this.localProject}) : super(key: key);

  final LocalProject localProject;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VistaListaProvider>(context, listen: false);

    final project = localProject.project;

    return FondoHome(
        contenido: ProjectContent(localProject: localProject),
        bottomNavigationBar: true,
        contenidoBottom: contenidoBottom(
            context: context,
            colorFondo: Color(0xff22B573),
            dosBotones: false,
            primerBotonDesactivado: false,
            segundoBotonDesactivado: project.pendienteAprobacion,
            txtPrimerBoton: null,
            txtSegundoBoton: 'Reportar Avance',
            accionPrimerBoton: null,
            accionSegundoBoton: () {
              if (project.pendienteAprobacion) {
                Toast.show(
                    "Lo sentimos, este proyecto esta pendiente de aprobación, sincroniza una vez mas el proyecto, si cree que este ya ha sido aprobado",
                    context,
                    duration: 5,
                    gravity: Toast.BOTTOM);
              } else if (localProject.periodoIdSeleccionado == null) {
                Toast.show(
                    "Lo sentimos, este proyecto no tiene periodos que reportar",
                    context,
                    duration: 3,
                    gravity: Toast.BOTTOM);
              } else {
                provider.cambiarPasoProyecto(project.codigoproyecto, 1);
                cambiarPagina(context, ReportarAvanceScreen());
              }
            }));
  }
}
