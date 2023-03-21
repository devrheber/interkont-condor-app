import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/proyecto/project_detail_provider.dart';
import 'package:appalimentacion/utils/datetime_format.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';
import '../../../globales/colores.dart';
import '../project_detail_provider.dart';

class DropDownPeriodo extends StatelessWidget {
  const DropDownPeriodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final periodoSeleccionado =
        context.watch<ProjectDetailProvider>().periodoSeleccionado;
    final detailProvider =
        Provider.of<ProjectDetailProvider>(context, listen: false);

    final periodos = detailProvider.detail?.periodos ?? [];
    periodos
        .sort((a, b) => a.getFechaIniDateTime.compareTo(b.getFechaIniDateTime));

    return Container(
      width: double.infinity,
      height: 58.0,
      margin: const EdgeInsets.only(
        bottom: 10.0,
        right: 28,
        left: 28,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(width: 0.5, color: AppTheme.cuarto),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Image.asset(
                'assets/img/Desglose/Home/icn-reloj.png',
                height: 17.82,
                width: 17.82,
              )),
          Expanded(
            flex: 6,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Periodo>(
                hint: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: const <Widget>[
                      AutoSizeText('Seleccione el periodo a reportar'),
                    ],
                  ),
                ),
                value: periodos.any((periodo) =>
                        periodo.periodoId == periodoSeleccionado?.periodoId)
                    ? periodoSeleccionado
                    : null,
                items: periodos
                    .map((value) => DropdownMenuItem<Periodo>(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: <Widget>[
                                const Text('del ', style: AppTheme.parrafo),
                                Text(
                                    DateTimeFormat.ddMMMYYYY(
                                        value.getFechaIniDateTime),
                                    style: AppTheme.parrafoNegrita),
                                const Text(' hasta el ',
                                    style: AppTheme.parrafo),
                                Text(
                                    DateTimeFormat.ddMMMYYYY(
                                        value.getFechaFinDateTime),
                                    style: AppTheme.parrafoNegrita),
                              ],
                            ),
                          ),
                          value: value,
                        ))
                    .toList(),
                onChanged: (Periodo? periodo) {
                  detailProvider.cambiarPeriodoReportado(periodo);
                },
                isExpanded: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
