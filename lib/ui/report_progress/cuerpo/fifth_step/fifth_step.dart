import 'package:flutter/material.dart';
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
          margin: const EdgeInsets.only(top: 164, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              FifthStepCard(
                title: 'Antes',
                colorTitle: const Color(0xff5994EF),
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
              const SizedBox(
                height: 12,
              ),
              FifthStepCard(
                title: 'Ahora',
                colorTitle: const Color(0xff7964F3),
                children: <FifthStepCardDetail>[
                  FifthStepCardDetail(
                    title: 'Asi va en',
                    value: PercentajeFormat.percentaje(cache.porcentajeAsiVaEn(project.valorproyecto)),
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
                            cache.porcentajeAsiVaEn(project.valorproyecto),
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
