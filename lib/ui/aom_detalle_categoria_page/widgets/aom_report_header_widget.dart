import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/widgets/step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AomReportHeaderWidget extends StatelessWidget {
  const AomReportHeaderWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final selectedStep =
        context.select((AomReportCubit cubit) => cubit.state.step);
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
    return Stack(children: [
      customedAppBar(
        title: title,
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
              style: selectedStep == 1 ? textStyleStepSelected : textStyleStep,
              // onTap: () => context.read<AomReportCubit>().setStep(1),
            ),
            StepIndicator(
              text: 'Actualización\nCualitativo',
              number: '2',
              isCompleted: selectedStep >= 2,
              completedColor: Color(0xFF1A8DBE),
              pendingColor: Color(0xFF745FF2),
              style: selectedStep == 2 ? textStyleStepSelected : textStyleStep,
              // onTap: () => context.read<AomReportCubit>().setStep(2),
            ),
            StepIndicator(
              text: 'Imágen o\n Video',
              number: '3',
              isCompleted: selectedStep >= 3,
              completedColor: Color(0xFF1A8DBE),
              pendingColor: Color(0xFF745FF2),
              style: selectedStep == 3 ? textStyleStepSelected : textStyleStep,
              // onTap: () => context.read<AomReportCubit>().setStep(3),
            ),
          ],
        ),
      ),
    ]);
  }
}
