import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cardContenido.dart';

NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
NumberFormat f2 = new NumberFormat("#,##0.00", "es_AR");

@override
class FifthStep extends StatelessWidget {
  const FifthStep({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final reportProgressService = Provider.of<ReportProgressProvider>(context);
    final project = reportProgressService.project;
    final cache = reportProgressService.cache;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 164.h, left: 20.sp, right: 20.sp),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              FifthStepCard(
                titulo: 'Antes',
                asivaTxt: 'Asi va',
                porcentajeAsiVa:
                    '${f.format((100 * (project.valorejecutado / project.valorproyecto)).round())}',
                porcentajeAsiVaDos:
                    '${((100 * (project.valorejecutado / project.valorproyecto)).round())}',
                dineroAsiVa: '${f2.format(project.valorejecutado)}',
                deberiaIrTxt: 'Deberia ir',
                porcentajeDeberiaIr:
                    '${f.format(project.porcentajeProyectado)}',
                dineroDeberiaIr:
                    '${f2.format((project.porcentajeProyectado / 100) * project.valorproyecto)}',
                esAntes: true,
                semaforo: '',
              ),
              SizedBox(
                height: 12.sp,
              ),
              FifthStepCard(
                titulo: 'Ahora',
                asivaTxt: 'Asi va en',
                porcentajeAsiVa:
                    '${f.format((cache.newExecutedValue / project.valorproyecto) * 100)}',
                porcentajeAsiVaDos:
                    '${((cache.newExecutedValue / project.valorproyecto) * 100)}',
                dineroAsiVa: '${f2.format(cache.newExecutedValue)}',
                deberiaIrTxt: 'Deberia ir en',
                porcentajeDeberiaIr:
                    '${f.format(cache.porcentajeValorProyectadoSeleccionado)}',
                dineroDeberiaIr:
                    '${f2.format((cache.porcentajeValorProyectadoSeleccionado / 100) * project.valorproyecto)}',
                esAntes: false,
                semaforo: '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
