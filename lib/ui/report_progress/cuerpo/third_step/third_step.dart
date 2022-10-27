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
                      margin: EdgeInsets.only(left: 20.0.sp, right: 20.0.sp),
                      padding: EdgeInsets.only(
                          right: 5.0.sp, left: 5.0.sp, bottom: 10.0.sp),
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
                    // SizedBox(height: 18.sp),

                    reportProgressService.detail.indicadoresAlcance.isNotEmpty
                        ?
                        // TODO Show apropiated message when list is empty

                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                height: 350.h,
                              ),
                              items: <Widget>[
                                for (final item in reportProgressService
                                    .detail.indicadoresAlcance)
                                  RangeIndicatorCard(
                                      valueSaved:
                                          reportProgressService.rangeIndicators[
                                                  item.indicadorAlcanceId
                                                      .toString()] ??
                                              '0',
                                      item: item,
                                      inputValue:
                                          '', // Value to indicator from cache
                                      onChanged: reportProgressService
                                          .onChangedRangeIndicatorCard)
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 25.sp, right: 25.sp, bottom: 22.sp),
                            child: TextSubtitle(
                                text:
                                    '- Este proyecto no presenta indicadores.'),
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
