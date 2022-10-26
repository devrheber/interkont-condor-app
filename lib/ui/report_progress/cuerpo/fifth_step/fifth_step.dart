import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';
import '../../report_progress_provider.dart';
import 'cardContenido.dart';

@override
class FifthStep extends StatelessWidget {
  const FifthStep({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final reportProgressService = Provider.of<ReportProgressProvider>(context);
    final project = reportProgressService.project;
    final detail = reportProgressService.detail;
    final cache = reportProgressService.cache;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 164.h, left: 20.sp, right: 20.sp),
          child: Column(
            children: <Widget>[
              FifthStepCard(
                title: 'Antes',
                colorTitle: Color(0xff5994EF),
                children: <FifthStepCardDetail>[
                  FifthStepCardDetail(
                    title: 'Asi va',
                    value: PercentajeFormat.percentaje(
                      project.asiVaPorcentajeDouble,
                    ),
                  ),
                  FifthStepCardDetail(
                    title: 'Debería ir',
                    value: PercentajeFormat.percentaje(
                      project.porcentajeProyectado,
                    ),
                  ),
                  FifthStepCardDetail(
                    title: 'Semáforo',
                    child: TrafficLight(
                      icon: project.getCurrentTrafficLightColor,
                    ),
                    showDivider: false,
                  ),
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),
              FifthStepCard(
                title: 'Ahora',
                colorTitle: Color(0xff7964F3),
                children: <FifthStepCardDetail>[
                  FifthStepCardDetail(
                    title: 'Asi va en',
                    value: PercentajeFormat.percentaje(
                      (cache.newExecutedValue / project.valorproyecto) * 100,
                    ),
                  ),
                  FifthStepCardDetail(
                    title: 'Debería ir en',
                    value: PercentajeFormat.percentaje(
                      project.porcentajeProyectado,
                    ),
                  ),
                  FifthStepCardDetail(
                    title: 'Programado del Periodo',
                    value: PercentajeFormat.percentaje(
                      cache.porcentajeValorProyectadoSeleccionado ?? 0,
                    ),
                  ),
                  FifthStepCardDetail(
                    title: 'Semáforo',
                    child: TrafficLight(
                      icon: project.getNewTrafficLightColor(
                        currentProgress:
                            (cache.newExecutedValue / project.valorproyecto) *
                                100,
                        projectedValue:
                            cache.porcentajeValorProyectadoSeleccionado ?? 0,
                        latePercentageLimit: detail.limitePorcentajeAtraso,
                        yellowLatePercentageLimit:
                            detail.limitePorcentajeAtrasoAmarillo,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
