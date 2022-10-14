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

  static Widget init() => ChangeNotifierProvider(
        create: (context) => ReportProgressProvider(
          projectsCacheRepository: context.read(),
        ),
        child: ReportProgressScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    final reportProgressProvider = Provider.of<ReportProgressProvider>(context);
    final numeroPaso = reportProgressProvider.stepNumber;

    void firstButtonMethod() {
      if (numeroPaso != 1) {
        // Paso Anterior
        reportProgressProvider.changeAndSaveStep(numeroPaso - 1);
        return;
      }

      // TODO Obtener datos de proyecto
      Toast.show("El avance ha sido cancelado", context,
          duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    }

    Future<bool> goToDelayFactors() async {
      if (numeroPaso != 2) return false;

      if (!reportProgressProvider.registerDelayFactors()) return false;

      final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DelayFactorScreen.init(),
      ));

      return result ?? false;

      // TODO Agregar Undo para deshacer borrado
    }

    Future<void> secondButtonMethod() async {
      final String errorMessage = reportProgressProvider.stepValidations();

      if (errorMessage != null) {
        Toast.show(errorMessage, context, duration: 3, gravity: Toast.BOTTOM);
        return;
      }

      if (numeroPaso == 2) {
        goToDelayFactors().then((value) {
          if (!value) return;

          reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
        });
      } else {
        reportProgressProvider.changeAndSaveStep(numeroPaso + 1);
      }
    }

    return FondoHome(
      body: ContenidoReportarAvance(numeroPaso: numeroPaso),
      bottomNavigationBar: CustomBottomNavigationBar(
        colorFondo: AppTheme.bottomPrincipal,
        primerBotonDesactivado: false,
        segundoBotonDesactivado: reportProgressProvider.secondButtonValidation,
        txtPrimerBoton: 'Cancelar',
        txtSegundoBoton: numeroPaso >= 5 ? 'Finalizar' : 'Siguiente Paso',
        accionPrimerBoton: () => firstButtonMethod(),
        accionSegundoBoton: () => secondButtonMethod(),
      ),
    );
  }
}
