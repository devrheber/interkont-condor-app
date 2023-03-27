import 'package:appalimentacion/ui/proyecto/bloc/project_detail_bloc.dart';
import 'package:appalimentacion/utils/datetime_format.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/models.dart';
import '../../../globales/colores.dart';

class DropDownPeriodo extends StatelessWidget {
  const DropDownPeriodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        final periodoSeleccionado = state.periodoSeleccionado;

        final detailBloc = BlocProvider.of<ProjectDetailBloc>(context);

        final periodos = [...detailBloc.state.detail.periodos];
        periodos.sort(
            (a, b) => a.getFechaIniDateTime.compareTo(b.getFechaIniDateTime));
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
                      if (periodo == null) return;
                      context.read<ProjectDetailBloc>().add(ChangePeriod(
                            periodo,
                          ));
                    },
                    isExpanded: true,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
