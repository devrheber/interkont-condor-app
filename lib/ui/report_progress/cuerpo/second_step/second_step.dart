import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../widgets/widgets.dart';
import '../../report_progress_provider.dart';
import 'customed_text_field.dart';
import 'qualitative_progress_card.dart';
import 'select_aspect.dart';

final titleColor = const Color(0xff444444);

class SecondStepBody extends StatefulWidget {
  const SecondStepBody({Key? key}) : super(key: key);

  @override
  SecondStepBodyState createState() => SecondStepBodyState();
}

class SecondStepBodyState extends State<SecondStepBody> {
  late TextEditingController achiveController;
  late TextEditingController difficultyController;

  @override
  void initState() {
    super.initState();
    achiveController = TextEditingController();
    difficultyController = TextEditingController();
  }

  @override
  void dispose() {
    achiveController.dispose();
    difficultyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportProgressService = Provider.of<ReportProgressProvider>(context);

    ToastContext().init(context);

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 230),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 31),
                padding: const EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const TextTitle(text: 'Avance Cualitativo'),
                    const SizedBox(height: 2),
                    const TextSubtitle(
                        text: '¿Qué logros y dificultades se presentaron?'),
                    const SizedBox(height: 18),
                    SelectAspect(
                      aspectSelected: reportProgressService.aspectSelected,
                      aspectsToEvaluate:
                          reportProgressService.detail.apectosEvaluar,
                      onChanged: reportProgressService.updateAspectSelected,
                    ),
                    CustomedTextField(
                      title: 'Ingrese los logros',
                      hintText:
                          'Acá puede agregar los logros que obtuvo el proyecto...',
                      onChanged: (String text) {},
                      controller: achiveController,
                    ),
                    CustomedTextField(
                      title: 'Ingrese las dificultades',
                      hintText:
                          'Acá puede agregar los dificultades que obtuvo el proyecto...',
                      onChanged: (String text) {},
                      controller: difficultyController,
                    ),
                    const SizedBox(height: 8),
                    AddGreenButton(
                      onTap: () {
                        if (achiveController.text.trim().isEmpty &&
                            difficultyController.text.trim().isEmpty) {
                          Toast.show('Registre al menos un logro o dificultad',
                              duration: 5);

                          return;
                        }

                        reportProgressService.addQualitativeProgress(
                          achive: achiveController.text,
                          difficulty: difficultyController.text,
                        );

                        FocusScope.of(context).requestFocus(FocusNode());

                        achiveController.clear();
                        difficultyController.clear();
                      },
                    ),
                    for (int i = 0;
                        i <
                            reportProgressService
                                .achievesAndDifficulties.length;
                        i++)
                      QualitativeProgressCard(
                        item: reportProgressService.achievesAndDifficulties[i],
                        deleteMethod: () =>
                            reportProgressService.removeQualitativeProgress(i),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
