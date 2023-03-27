import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../widgets/widgets.dart';
import '../../report_progress_provider.dart';
import 'card_carousel_avances.dart';
import 'local_widgets/performance_indicators.dart';

const titleColor = Color(0xff444444);

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
          margin: const EdgeInsets.only(
            top: 230,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        TextTitle(text: 'Indicador de alcance'),
                        SizedBox(height: 2),
                        TextSubtitle(
                            text:
                                'Ingrese indicadores de alcance en el periodo'),
                      ],
                    ),
                  ),
                  // SizedBox(height: 18),

                  reportProgressService.detail.indicadoresAlcance.isNotEmpty
                      ?
                      // TODO Show apropiated message when list is empty

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              height: 350,
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
                      : const Padding(
                          padding:
                              EdgeInsets.only(left: 25, right: 25, bottom: 22),
                          child: TextSubtitle(
                              text: '- Este proyecto no presenta indicadores.'),
                        ),

                  // TODO Solo debe ser visible para app avanzame
                  // const PerformanceIndicators(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
