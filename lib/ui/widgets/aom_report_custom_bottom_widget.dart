import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/custom_bottom_navigation_bar.dart';

class AomReportCustomBottomWidget extends StatelessWidget {
  const AomReportCustomBottomWidget({
    Key? key,
    this.backMethod,
    required this.forwardMethod,
    this.forwardTitle = 'Siguiente',
    this.backTitle = 'Atrás',
  }) : super(key: key);

  final VoidCallback? backMethod;
  final VoidCallback forwardMethod;
  final String forwardTitle;
  final String backTitle;

  @override
  Widget build(BuildContext context) {
    final isKeyboarOpen =
        context.select((AomReportCubit cubit) => cubit.state.isKeyboardOpen);

    if (isKeyboarOpen) {
      return const SizedBox.shrink();
    }
    return Positioned(
      bottom: 0,
      left: 0,
      child: FadeIn(
        child: Container(
          color: ColorTheme.aomBackgroundColor,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10),
          child: CustomBottomNavigationBar(
              colorFondo: AppTheme.bottomPrincipal,
              primerBotonDesactivado: false,
              segundoBotonDesactivado: false,
              txtPrimerBoton: backTitle,
              txtSegundoBoton: forwardTitle,
              accionPrimerBoton: backMethod ?? () => Navigator.pop(context),
              accionSegundoBoton: forwardMethod),
        ),
      ),
    );
  }
}
