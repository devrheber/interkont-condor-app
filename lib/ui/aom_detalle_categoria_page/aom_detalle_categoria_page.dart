import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/aom_report_step_1/view/view.dart';
import 'package:appalimentacion/ui/aom_report_step_2/view/view.dart';
import 'package:appalimentacion/ui/aom_report_step_3/view/view.dart';

import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';

import 'package:appalimentacion/ui/widgets/step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      create: (_) => AomCategoryDetailCubit()..setStep(paso),
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
        context.select((AomCategoryDetailCubit cubit) => cubit.state.step);

    TextStyle textStyleStepSelected = TextStyle(
      fontFamily: "montserrat",
      fontSize: 10.sp,
      color: Color(0xff556A8D),
      fontWeight: FontWeight.w700,
    );

    TextStyle textStyleStep = TextStyle(
      fontFamily: "montserrat",
      fontSize: 10.sp,
      color: Color(0xff556A8D),
      fontWeight: FontWeight.w400,
    );

    return FondoHome(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 15.sp),
        child: CustomBottomNavigationBar(
          colorFondo: AppTheme.bottomPrincipal,
          primerBotonDesactivado: false,
          segundoBotonDesactivado: false,
          txtPrimerBoton: 'Atrás',
          txtSegundoBoton:
              selectedStep >= 3 ? 'Finalizar Actualización' : 'Siguiente Paso',
          accionPrimerBoton: () {
            Navigator.pop(context);
          },
          accionSegundoBoton: () {
            if (selectedStep == 3) {
              Navigator.pushNamed(
                context,
                AppRoutes.aomLastStep,
              );
              return;
            }
            context.read<AomCategoryDetailCubit>().setStep(selectedStep + 1);
          },
        ),
      ),
      body: Stack(
        children: [
          customedAppBar(
            title: nombre,
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            width: double.infinity,
            height: 90.h,
            margin: EdgeInsets.only(top: 164.h, right: 28.sp, left: 28.sp),
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff444444).withOpacity(.1),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StepIndicator(
                  text: 'Detalle de\nlos Activos',
                  number: '1',
                  isCompleted: selectedStep >= 1,
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style:
                      selectedStep == 1 ? textStyleStepSelected : textStyleStep,
                ),
                StepIndicator(
                  text: 'Actualización\nCualitativo',
                  number: '2',
                  isCompleted: selectedStep >= 2,
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style:
                      selectedStep == 2 ? textStyleStepSelected : textStyleStep,
                ),
                StepIndicator(
                  text: 'Imágen o\n Video',
                  number: '3',
                  isCompleted: selectedStep >= 3,
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style:
                      selectedStep == 3 ? textStyleStepSelected : textStyleStep,
                ),
              ],
            ),
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
          )
        ],
      ),
    );
  }
}
