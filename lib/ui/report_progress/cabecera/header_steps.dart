import 'package:appalimentacion/ui/widgets/step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const titleColor = Color(0xff444444);

class HeaderSteps extends StatelessWidget {
  const HeaderSteps({Key? key, required this.pasoSeleccionado})
      : super(key: key);

  final int pasoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90.sp,
      margin: EdgeInsets.only(top: 164.sp, right: 28.sp, left: 28.sp),
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StepIndicator(
            text: 'Ingrese el avance',
            number: '1',
            isCompleted: (pasoSeleccionado >= 1),
          ),
          StepIndicator(
            text: 'Avance cualitativo',
            number: '2',
            isCompleted: (pasoSeleccionado >= 2),
          ),
          StepIndicator(
            text: 'Indicador de alcance',
            number: '3',
            isCompleted: (pasoSeleccionado >= 3),
          ),
          StepIndicator(
            text: 'Descripción & Documentos',
            number: '4',
            isCompleted: (pasoSeleccionado >= 4),
          )
        ],
      ),
    );
  }
}
