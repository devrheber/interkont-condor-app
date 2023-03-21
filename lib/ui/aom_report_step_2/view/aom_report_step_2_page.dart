import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';
import 'package:appalimentacion/ui/aom_report_step_2/bloc/aom_report_step_2_bloc.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../widgets/widgets.dart';

class AomReportStep2Page extends StatelessWidget {
  const AomReportStep2Page({
    Key? key,
    required this.vidaUtilEnMeses,
  }) : super(key: key);

  final int vidaUtilEnMeses;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AomReportStep2Bloc(vidaUtilEnMeses),
      child: const AomReportStep2View(),
    );
  }
}

class AomReportStep2View extends StatelessWidget {
  const AomReportStep2View({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AomReportStep2Bloc>();

    String getVidaUtilEnAnios(int months) => (months / 12).toStringAsFixed(2);

    return BlocBuilder<AomReportStep2Bloc, AomReportStep2State>(
        builder: (context, state) {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 265, left: 28, right: 28),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Center(
                  child: Text(
                    'Vida remantente actual del activo:',
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${state.vidaUtilEnMeses.toString()} Meses (${getVidaUtilEnAnios(state.vidaUtilEnMeses)} Años)',
                    // '$monthsInitialValue Meses (20,08 Años)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                QuestionOne(
                  initialValue: state.answers[0] ? 1 : 0,
                  monthsInitialValue: state.vidaUtilRemanenteConsideradaOff,
                  onChangedAnswer: (int value) {
                    bloc.add(UpdateAnwserEvent(0, answer: value == 1));
                  },
                  onChangedReason: (String value) {
                    bloc.add(UpdateQuestion1ReasonEvent(value));
                  },
                  onChangedMonths: (String value) {
                    bloc.add(UpdateQuestion1MonthsEvent(value));
                  },
                ),
                const Text(
                  'Evidencias Externas:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorTheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '2. ¿El activo a disminuido su valor de mercado significativamente más de lo esperado por el paso del tiempo o de su uso normal?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[1] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(1, answer: value == 1));
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '3. ¿Durante el periodo se evidencian cambios adversos de tipo legal o económico que afecte el valor de mercado del activo o la forma en que este es utilizado por Minergia?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[2] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(2, answer: value == 1));
                  },
                ),
                const Text(
                  'Deterioro de Valor:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorTheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '4. ¿El activo tiene evidencias de daño físico que den como resultado una disminución de su capacidad productiva o de su valor de mercado?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[3] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(3, answer: value == 1));
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '5. ¿Han tenido lugar, o se espera que tengan lugar en un futuro inmediato, cambio en la forma en que se usa el activo lo cual conlleve a una disminución del potencial de servicio del activo?\n(Ej. Se deje de utilizar)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[4] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(4, answer: value == 1));
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '6. ¿Se decide detener la construcción del activo antes de su finalización o de su puesta en condiciones de funcionamiento?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[5] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(5, answer: value == 1));
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    '7. ¿Se dispone de evidencia procedente de informes internos que indican que la capacidad del activo para suministrar bienes o servicios, ha disminuido o va a ser inferior a la esperada?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorTheme.darkShade,
                    ),
                  ),
                ),
                YesNoPurple(
                  initialValue: state.answers[6] ? 1 : 0,
                  onChanged: (int? value) {
                    bloc.add(UpdateAnwserEvent(6, answer: value == 1));
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          AomReportCustomBottomWidget(
            forwardMethod: () {
              if (!bloc.state.isStateValid()) {
                Toast.show(
                  'Debe completar todos los campos de la pregunta 1.',
                  duration: 5,
                );
                return;
              }

              context.read<AomReportCubit>().updateData(
                    answers: bloc.state.answers,
                    vidaUtilRemanenteNoConsideradaText:
                        bloc.state.vidaUtilRemanenteNoConsideradaText,
                    vidaUtilRemanenteConsideradaOff: bloc.state.getNewVidaUtil,
                  );
              context.read<AomReportCubit>().setStep(3);
            },
            backMethod: () {
              context.read<AomReportCubit>().setStep(1);
            },
            backTitle: 'Retroceder',
          ),
        ],
      );
    });
  }
}
