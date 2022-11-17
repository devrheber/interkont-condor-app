import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/aom_report_step_1/view/view.dart';
import 'package:appalimentacion/ui/aom_report_step_2/view/view.dart';
import 'package:appalimentacion/ui/aom_report_step_3/view/view.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/aom_report_header_widget.dart';

class AomDetalleCategoriaPage extends StatelessWidget {
  const AomDetalleCategoriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String nombre = arguments['nombre'];
    final paso = arguments['paso'];
    final clasificationId = arguments['clasificationId'];
    final projectCode = arguments['projectCode'];
    return BlocProvider(
      create: (_) => AomReportCubit()..setStep(paso),
      child: AomDetalleCategoriaView(
        nombre: nombre,
        projectCode: projectCode,
        clasificationId: clasificationId,
      ),
    );
  }
}

class AomDetalleCategoriaView extends StatelessWidget {
  const AomDetalleCategoriaView({
    Key? key,
    required this.nombre,
    required this.projectCode,
    required this.clasificationId,
  }) : super(key: key);

  final String nombre;

  final int projectCode;
  final int clasificationId;

  @override
  Widget build(BuildContext context) {
    final selectedStep =
        context.select((AomReportCubit cubit) => cubit.state.step);

    return Stack(
      children: [
        FondoHome(
          body: Stack(
            children: [
              AomReportHeaderWidget(
                title: nombre,
              ),
              IndexedStack(
                index: (selectedStep - 1).clamp(0, 2),
                children: [
                  AomReportStep1Page.init(
                    projectCode: projectCode,
                    clasificationId: clasificationId,
                  ),
                  const AomReportStep2Page(),
                  const AomReportStep3Page(),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
