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
    final categoryId = arguments['categoryId'];
    final projectCode = arguments['projectCode'];
    final vidaUtilEnMeses = arguments['vidaUtilEnMeses'];
    return BlocProvider(
      create: (_) => AomReportCubit(
        projectCode: projectCode,
        clasificationId: clasificationId,
        vidaUtilActualEnMeses: vidaUtilEnMeses,
      )..setStep(paso),
      child: AomDetalleCategoriaView(
        nombre: nombre,
        projectCode: projectCode,
        clasificationId: clasificationId,
        vidaUtilEnMeses: vidaUtilEnMeses,
        categoryId: categoryId,
      ),
    );
  }
}

class AomDetalleCategoriaView extends StatefulWidget {
  const AomDetalleCategoriaView({
    Key? key,
    required this.nombre,
    required this.projectCode,
    required this.categoryId,
    required this.clasificationId,
    required this.vidaUtilEnMeses,
  }) : super(key: key);

  final String nombre;

  final int projectCode;
  final int clasificationId;
  final int categoryId;
  final int vidaUtilEnMeses;

  @override
  State<AomDetalleCategoriaView> createState() =>
      _AomDetalleCategoriaViewState();
}

class _AomDetalleCategoriaViewState extends State<AomDetalleCategoriaView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateKeyboarState();
  }

  void updateKeyboarState() {
    final value = MediaQuery.of(context).viewInsets.bottom != 0;

    if (context.read<AomReportCubit>().state.isKeyboardOpen == (value)) {
      return;
    }

    context.read<AomReportCubit>().updateKeyboardState(value);
  }

  @override
  Widget build(BuildContext context) {
    final selectedStep =
        context.select((AomReportCubit cubit) => cubit.state.step);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          FondoHome(
            body: Stack(
              children: [
                AomReportHeaderWidget(
                  title: widget.nombre,
                ),
                IndexedStack(
                  index: (selectedStep - 1).clamp(0, 2),
                  children: [
                    AomReportStep1Page.init(
                      projectCode: widget.projectCode,
                      categoryId: widget.categoryId,
                    ),
                    AomReportStep2Page(
                      vidaUtilEnMeses: widget.vidaUtilEnMeses,
                    ),
                    const AomReportStep3Page(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
