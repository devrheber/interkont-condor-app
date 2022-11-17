import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';

class AomReportStep2Page extends StatelessWidget {
  const AomReportStep2Page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int monthsInitialValue = 241;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Text(
                  'Vida remantente actual del activo:',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$monthsInitialValue Meses (20,08 Años)',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              QuestionOne(monthsInitialValue: monthsInitialValue),
              Text(
                'Evidencias Externas:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorTheme.primary,
                ),
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '2. ¿El activo a disminuido su valor de mercado significativamente más de lo esperado por el paso del tiempo o de su uso normal?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '3. ¿Durante el periodo se evidencian cambios adversos de tipo legal o económico que afecte el valor de mercado del activo o la forma en que este es utilizado por Minergia?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              Text(
                'Deterioro de Valor:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorTheme.primary,
                ),
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '4. ¿El activo tiene evidencias de daño físico que den como resultado una disminución de su capacidad productiva o de su valor de mercado?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '5. ¿Han tenido lugar, o se espera que tengan lugar en un futuro inmediato, cambio en la forma en que se usa el activo lo cual conlleve a una disminución del potencial de servicio del activo?\n(Ej. Se deje de utilizar)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '6. ¿Se decide detener la construcción del activo antes de su finalización o de su puesta en condiciones de funcionamiento?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Text(
                  '7. ¿Se dispone de evidencia procedente de informes internos que indican que la capacidad del activo para suministrar bienes o servicios, ha disminuido o va a ser inferior a la esperada?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.darkShade,
                  ),
                ),
              ),
              YesNoPurple(
                onChanged: (int? value) {},
              ),
              SizedBox(height: 100.sp),
            ],
          ),
        ),
        AomReportCustomBottomWidget(
          forwardMethod: () => context.read<AomReportCubit>().setStep(3),
        ),
      ],
    );
  }
}
