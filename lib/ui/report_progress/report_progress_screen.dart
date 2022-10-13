import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'contenido.dart';
import 'cuerpo/delay_factor/delay_factor_screen.dart';

class ReportProgressScreen extends StatelessWidget {
  const ReportProgressScreen._();

  static Widget init({
    @required Project project,
    @required DatosAlimentacion detail,
  }) =>
      ChangeNotifierProvider(
        create: (context) => ReportarAvanceProvider(
          project: project,
          detail: detail,
          projectsCacheRepository: context.read(),
        ),
        child: ReportProgressScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final reportProgressProvider = Provider.of<ReportarAvanceProvider>(context);
    final numeroPaso = reportProgressProvider.stepNumber;

    return FondoHome(
      body: ContenidoReportarAvance(numeroPaso: numeroPaso),
      bottomNavigationBar: CustomBottomNavigationBar(
        colorFondo: AppTheme.bottomPrincipal,
        primerBotonDesactivado: false,
        segundoBotonDesactivado: false, // TODO
        txtPrimerBoton: 'Cancelar',
        txtSegundoBoton: numeroPaso >= 5 ? 'Finalizar' : 'Siguiente Paso',
        accionPrimerBoton: () {
          if (numeroPaso != 1) {
            // Paso Anterior
            reportProgressProvider.changeAndSaveStep(numeroPaso - 1);
            return;
          }

          // TODO Obtener datos de proyecto
          Toast.show("El avance ha sido cancelado", context,
              duration: 5, gravity: Toast.BOTTOM);
          Navigator.pop(context);
        },
        accionSegundoBoton: () async {
          if (numeroPaso == 1) {}
          if (numeroPaso == 2) {
            final result = reportProgressProvider.registerDelayFactors();
            if (result) {
              final confirm = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DelayFactorScreen.init(),
                ),
              );

              if (confirm) {
                reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
              }
              return;
            }

            reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
          }

          if (numeroPaso == 3) {
            reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
          }

          if (numeroPaso >= 5) {
            // TODO Navegar a CargandoFinalizar
          }
          reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
        },
      ),
    );
  }
}
