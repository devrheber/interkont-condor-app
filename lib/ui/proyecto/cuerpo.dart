import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/models/project.dart';
import 'package:appalimentacion/ui/proyecto/bloc/project_detail_bloc.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/models/models.dart';
import '../../domain/models/project.dart';
import '../../globales/colores.dart';
import 'widgets/seleccionaPeriodo.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
      final projectCache = state.cache;
      final project = state.project;

      return Column(
        children: <Widget>[
          projectCache.lastSyncDate == null
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20, left: 28, right: 28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 20.0,
                        margin: const EdgeInsets.only(bottom: 5.0, right: 10.0),
                        child: Image.asset(
                          'assets/img/Desglose/Demas/icn-alert.png',
                        ),
                      ),
                      const Expanded(
                          child: Text(
                              // 'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                              'Debes sincronizar el proyecto para poder reportar tu avance',
                              style: TextStyle(
                                fontFamily: "montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xffC1272D),
                              ),
                              textAlign: TextAlign.left))
                    ],
                  ))
              : const SizedBox.shrink(),
          const SizedBox(height: 15),
          Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Summary(
                    porcentajeAsiVa: project.asiVaPorcentajeDouble,
                    project: project,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        right: 28, left: 28, bottom: 5.0),
                    child: const Text(
                      'Seleccione el periodo a reportar',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff030303),
                        fontFamily: "montserrat",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const DropDownPeriodo()
                ],
              ),
              if (project.pendienteAprobacion)
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    color: AppTheme.rojoBackground,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 20.0,
                        margin:
                            const EdgeInsets.only(bottom: 5.0, right: 10.0),
                        child: Image.asset(
                          'assets/img/Desglose/Demas/icn-alert.png',
                          // width: 100.0,
                        ),
                      ),
                      const Expanded(
                          child: Text(
                              'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                              // 'Debes sincronizar el proyecto para poder reportar tu avance',
                              style: AppTheme.parrafoRojo,
                              textAlign: TextAlign.left))
                    ],
                  ),
                )
              else
                const Text(''),
            ],
          ),
        ],
      );
    });
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    Key? key,
    required this.porcentajeAsiVa,
    required this.project,
  }) : super(key: key);

  final double porcentajeAsiVa;
  final Project project;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f2 = NumberFormat("#,##0.00", "en_US");
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0, left: 28, right: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 20.0, left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          _Celdas(
            leftText: 'Presupuesto',
            rightText: '\$ ${f2.format(project.valorproyecto)}',
          ),
          _Celdas(
            leftText: 'Asi va',
            rightText: PercentajeFormat.percentaje(porcentajeAsiVa),
          ),
          _Celdas(
            leftText: 'Asi deberia ir',
            rightText:
                PercentajeFormat.percentaje(project.porcentajeProyectado),
          ),
          _Celdas(
            leftText: 'Contratista',
            rightText: '${project.contratista}',
          ),
          _Celdas(
            leftText: 'Semaforo',
            rightText: '${project.semaforoproyecto}',
            semaforo: true,
          ),
        ],
      ),
    );
  }
}

class _Celdas extends StatelessWidget {
  const _Celdas({
    Key? key,
    this.semaforo = false,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);

  final bool semaforo;
  final String leftText;
  final String rightText;

  String get iconoSemaforo {
    if (semaforo == true) {
      if (rightText == 'amarillo') {
        return 'semaforo-2';
      }
      if (rightText == 'verde') {
        return 'semaforo-1';
      }
    }
    return 'semaforo-3';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: semaforo
          ? const EdgeInsets.only(top: 10.0)
          : const EdgeInsets.only(bottom: 10.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border(
            bottom: !semaforo
                ? const BorderSide(width: 0.3, color: Colors.black)
                : const BorderSide(width: 0.0, color: Colors.white)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$leftText',
              style: const TextStyle(
                fontFamily: "montserrat",
                fontSize: 14,
                color: Color(0xff333333),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: semaforo
                ? Container(
                    height: 20.0,
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/Desglose/Home/' + iconoSemaforo + '.png',
                        ),
                      ],
                    ),
                  )
                : Text(
                    rightText == 'null' ? '---' : '$rightText',
                    style: const TextStyle(
                      fontSize: 13.93,
                      fontFamily: "montserrat",
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
