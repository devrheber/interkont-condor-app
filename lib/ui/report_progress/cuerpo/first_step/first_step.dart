import 'package:appalimentacion/ui/report_progress/cuerpo/first_step/first_step_provider.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/first_step/progress_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../widgets/title_subtitle.dart';
import 'buscador.dart';

final titleColor = Color(0xff444444);

class FirstStepBody extends StatelessWidget {
  const FirstStepBody._();

  static Widget init() {
    return ChangeNotifierProvider(
      create: (context) =>
          FirstStepProvider(projectsCacheRepository: context.read()),
      child: const FirstStepBody._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstStepProvider = Provider.of<FirstStepProvider>(context);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextTitle(text: 'Ingrese el avance'),
                    SizedBox(height: 2.sp),
                    TextSubtitle(
                        text: 'Ingrese cantidad de avance por actividad'),
                  ],
                ),
              ),
              SizedBox(height: 18.sp),
              Padding(
                padding: EdgeInsets.only(left: 30.0.sp, right: 34.sp),
                child: buscador(
                  onChanged: (value) {
                    firstStepProvider.txtBuscarAvance = value;
                  },
                  onPressed: () => firstStepProvider
                      .filter(firstStepProvider.txtBuscarAvance),
                ),
              ),
              SizedBox(height: 26.23.sp),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeCenterPage: true,
                  height: 435.0.h,
                ),
                items: <Widget>[
                  for (final activity in firstStepProvider.filteredActivites)
                    ProgressCard(
                      activity: activity,
                      valueSaved: (firstStepProvider
                          .activitiesProgress[activity.actividadId.toString()]),
                      onChanged: (value) {
                        firstStepProvider.saveValue(
                          activity.actividadId,
                          value,
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
