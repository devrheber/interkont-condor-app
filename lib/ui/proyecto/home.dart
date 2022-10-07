import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/listaProyectos/project_detail_provider.dart';
import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/ui/widgets/home/contenidoBottom.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';

import '../reportarAvance/home.dart';
import 'contenido.dart';

class ProyectoScreen extends StatelessWidget {
  const ProyectoScreen._();

  static Widget init({
    @required Project project,
    @required DatosAlimentacion detail,
  }) =>
      ChangeNotifierProvider(
        lazy: true,
        create: (context) => ProjectDetailProvider(
          project: project,
          detail: detail,
          prefs: context.read(),
          projectRepository: context.read(),
          projectsCacheRepository: context.read(),
        ),
        child: const ProyectoScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<ProjectDetailProvider>(context);
    final project = detailProvider.project;

    return FondoHome(
      contenido: ProjectContent(
          project: detailProvider.project, projectCache: detailProvider.cache),
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
          } else if (detailProvider.cache.periodoIdSeleccionado == null) {
            Toast.show(
                "Lo sentimos, este proyecto no tiene periodos que reportar",
                context,
                duration: 3,
                gravity: Toast.BOTTOM);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ReportarAvanceScreen.init(
                      project: project,
                      detail: detailProvider.detail,
                      cache: context
                          .read<ProjectsProvider>()
                          .cache[project.codigoproyecto.toString()]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
