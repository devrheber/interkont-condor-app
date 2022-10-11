import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/listaProyectos/project_detail_provider.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_screen.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';
import 'contenido.dart';

class ProyectoScreen extends StatelessWidget {
  const ProyectoScreen._();

  static Widget init({
    @required Project project,
    @required DatosAlimentacion detail,
    @required ProjectCache cache,
  }) =>
      ChangeNotifierProvider(
        lazy: true,
        create: (context) => ProjectDetailProvider(
          project: project,
          detail: detail,
          cache: cache,
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
      body: ProjectContent(
        project: detailProvider.project,
        projectCache: detailProvider.cache,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        colorFondo: Color(0xff22B573),
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
          } else if (detailProvider.cache?.periodoIdSeleccionado == null) {
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
                  return ReportProgressScreen.init(
                    project: project,
                    detail: detailProvider.detail,
                    cache: detailProvider.cache,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
