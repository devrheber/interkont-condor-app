import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../widgets/widgets.dart';
import '../../report_progress_provider.dart';
import 'card_carousel_avances.dart';
import 'local_widgets/performance_indicators.dart';

final titleColor = Color(0xff444444);

class ThirdStep extends StatelessWidget {
  const ThirdStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportProgressService = Provider.of<ReportProgressProvider>(context);

    ToastContext().init(context);
    
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      padding:
                          EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextTitle(text: 'Indicador de alcance'),
                          SizedBox(height: 2.sp),
                          TextSubtitle(
                              text:
                                  'Ingrese indicadores de alcance en el periodo'),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.sp),
                    if (reportProgressService.rangeIndicators.isEmpty)
                      // TODO Show apropiated message
                      Visibility(
                        visible:
                            reportProgressService.rangeIndicators.isNotEmpty,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            height: 350.h,
                          ),
                          items: <Widget>[
                            for (int i = 0;
                                i <
                                    reportProgressService
                                        .rangeIndicators.length;
                                i++)
                              RangeIndicatorCard(
                                item: reportProgressService.rangeIndicators[i],
                                inputValue: '', // Value to indicator from cache
                                onChanged: (value) {
                                  if (double.parse('$value') < 0) {
                                    Toast.show(
                                        "Lo sentimos, solo aceptamos numeros positivos",
                                        duration: 3,
                                        gravity: Toast.bottom);
                                  }
                                  reportProgressService
                                      .onChangedRangeIndicatorCard(
                                          index: i, value: value);
                                },
                              )
                          ],
                        ),
                      ),
                    const PerformanceIndicators(),
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
