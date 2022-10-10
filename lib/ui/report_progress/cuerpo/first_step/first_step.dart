import 'package:appalimentacion/ui/report_progress/cuerpo/first_step/progress_card.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../widgets/title_subtitle.dart';
import 'buscador.dart';

final titleColor = Color(0xff444444);

class FirstStepBody extends StatefulWidget {
  const FirstStepBody({
    Key key,
  }) : super(key: key);

  @override
  FirstStepBodyState createState() => FirstStepBodyState();
}

class FirstStepBodyState extends State<FirstStepBody> {
  // Ingrese cantidad de avance por actividad
  // TODO Saved this value in cache
  String txtBuscarAvance = '';

  String otros;

  @override
  Widget build(BuildContext context) {
    final reportProgressProvider = Provider.of<ReportarAvanceProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          // color: Colors.black,
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
                child: buscador(onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      // actividadesFilter = actividades;
                    });
                  }
                  txtBuscarAvance = value;
                }, onPressed: () {
                  // TODO
                  // filter();
                  reportProgressProvider.filter(txtBuscarAvance);
                }),
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
                  for (final activity
                      in reportProgressProvider.filteredActivites)
                    ProgressCard(
                      activity: activity,
                      valueSaved: (reportProgressProvider.activitiesProgress[
                              activity.actividadId.toString()] ??
                          '0'),
                      onChanged: (value) {
                        reportProgressProvider.saveValue(
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
