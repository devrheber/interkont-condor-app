import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';

import 'customed_text_field.dart';
import 'qualitative_progress_card.dart';
import 'select_aspect.dart';

final titleColor = Color(0xff444444);

class SecondStepBody extends StatefulWidget {
  const SecondStepBody({Key key}) : super(key: key);

  @override
  SecondStepBodyState createState() => SecondStepBodyState();
}

class SecondStepBodyState extends State<SecondStepBody> {
  TextEditingController achiveController;
  TextEditingController difficultyController;

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

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 230.h),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 31.sp),
                padding: EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const TextTitle(text: 'Avance Cualitativo'),
                    SizedBox(height: 2.sp),
                    const TextSubtitle(
                        text: '¿Qué logros y dificultades se presentaron?'),
                    SizedBox(height: 18.sp),
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
                      onChanged: (texto) {
                        // TODO
                      },
                      controller: achiveController,
                    ),
                    CustomedTextField(
                      title: 'Ingrese las dificultades',
                      hintText:
                          'Acá puede agregar los dificultades que obtuvo el proyecto...',
                      onChanged: (texto) {
                        // TODO
                      },
                      controller: difficultyController,
                    ),
                    SizedBox(height: 8.sp),
                    AddGreenButton(
                      onTap: () {
                        if (achiveController.text.isEmpty) return;
                        if (difficultyController.text.isEmpty) return;
                        // TODO Show toast or show error validate

                        reportProgressService.addQualitativeProgress(
                          achive: achiveController.text,
                          difficulty: difficultyController.text,
                        );

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
