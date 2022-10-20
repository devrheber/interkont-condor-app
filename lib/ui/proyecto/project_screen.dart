import 'package:appalimentacion/ui/proyecto/project_detail_provider.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_screen.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';
import 'contenido.dart';

class ProyectScreen extends StatelessWidget {
  const ProyectScreen._();

  static Widget init() => ChangeNotifierProvider(
        lazy: true,
        create: (context) => ProjectDetailProvider(
          projectRepository: context.read(),
          projectsCacheRepository: context.read(),
        ),
        child: const ProyectScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<ProjectDetailProvider>(context);
    final project = detailProvider.project;

    ToastContext().init(context);

    void goToNextScreen() {
      if (project.pendienteAprobacion) {
        Toast.show(
            'Lo sentimos, este proyecto esta pendiente de aprobación, sincroniza una vez mas el proyecto, si cree que este ya ha sido aprobado',
            duration: 5,
            gravity: Toast.bottom);
        return;
      }
      if (detailProvider.cache.synchronizationRequired) {
        Toast.show('Debe sincronizar el proyecto',
            duration: 5, gravity: Toast.bottom);
        return;
      }

      if ((detailProvider.detail?.periodos.isEmpty ?? true)) {
        Toast.show('Lo sentimos, este proyecto no tiene periodos que reportar',
            duration: 3, gravity: Toast.bottom);
        return;
      }
      if (detailProvider.periodoSeleccionado == null) {
        Toast.show('Seleccione el periodo a reportar',
            duration: 3, gravity: Toast.bottom);

        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ReportProgressScreen.init();
          },
        ),
      );
    }

    return FondoHome(
      body: ProjectContent(
        project: detailProvider.project,
        projectCache: detailProvider.cache,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          colorFondo: Color(0xff22B573),
          primerBotonDesactivado: false,
          segundoBotonDesactivado: project.pendienteAprobacion ||
              (detailProvider.cache.synchronizationRequired),
          txtPrimerBoton: null,
          txtSegundoBoton: 'Reportar Avance',
          accionPrimerBoton: null,
          accionSegundoBoton: () => goToNextScreen()),
    );
  }
}
