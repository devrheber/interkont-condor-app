import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final titleColor = Color(0xff444444);

class FifthStepCard extends StatelessWidget {
  const FifthStepCard({
    Key key,
    this.titulo,
    this.asivaTxt,
    this.porcentajeAsiVa,
    this.porcentajeAsiVaDos,
    this.dineroAsiVa,
    this.deberiaIrTxt,
    this.porcentajeDeberiaIr,
    this.dineroDeberiaIr,
    this.esAntes,
    this.semaforo,
  }) : super(key: key);

  final String titulo;
  final String asivaTxt;
  final String porcentajeAsiVa;
  final String porcentajeAsiVaDos;
  final String dineroAsiVa;
  final String deberiaIrTxt;
  final String porcentajeDeberiaIr;
  final String dineroDeberiaIr;
  final bool esAntes;
  final String semaforo;

  @override
  Widget build(BuildContext context) {
    final reportProgressService = Provider.of<ReportProgressProvider>(context);
    final cache = reportProgressService.cache;
    
    final detail = reportProgressService.detail;

    String nombreSemaforo = reportProgressService.project.semaforoproyecto;

    if (esAntes) {
      nombreSemaforo = reportProgressService.project.semaforoproyecto;
    } else {
      var datoVerde = (100 -
          ((double.parse('$porcentajeAsiVaDos') /
                  cache.porcentajeValorProyectadoSeleccionado) *
              100));
      if (datoVerde <= detail.limitePorcentajeAtraso) {
        nombreSemaforo = 'verde';
      } else if (datoVerde > detail.limitePorcentajeAtraso &&
          datoVerde <= detail.limitePorcentajeAtrasoAmarillo) {
        nombreSemaforo = 'amarillo';
      } else if (datoVerde > detail.limitePorcentajeAtrasoAmarillo) {
        nombreSemaforo = 'rojo';
      }
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: 22.sp, left: 23.sp, right: 22.0.sp, bottom: 25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              '$titulo',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color:
                    titulo == "Antes" ? Color(0xff5994EF) : Color(0xff7964F3),
              ),
            ),
            celdas(
              txtPrimero: '$asivaTxt',
              txtSegundo: '$porcentajeAsiVa%',
              // txtTercero: '\$ $dineroAsiVa',
              semaforo: false,
              nombreSemaforo: '',
            ),
            celdas(
              txtPrimero: '$deberiaIrTxt',
              txtSegundo: '$porcentajeDeberiaIr%',
              // txtTercero: '\$ $dineroDeberiaIr',
              semaforo: false,
              nombreSemaforo: '',
            ),
            Visibility(
              visible: titulo == "Ahora",
              child: celdas(
                txtPrimero: 'Programado del Periodo',
                txtSegundo: '79%',
                // txtTercero: 'tercero',
                semaforo: false,
                nombreSemaforo: nombreSemaforo,
              ),
            ),
            celdas(
              txtPrimero: 'Semaforo',
              txtSegundo: 'segundo',
              // txtTercero: 'tercero',
              semaforo: true,
              nombreSemaforo: nombreSemaforo,
            ),
          ],
        ),
      ),
    );
  }
}

Widget celdas(
    {String txtPrimero,
    txtSegundo,
    // txtTercero,
    nombreSemaforo,
    bool semaforo}) {
  String iconoSemaforo = 'semaforo-3';
  if (nombreSemaforo == 'rojo') {
    iconoSemaforo = 'semaforo-3';
  } else if (nombreSemaforo == 'amarillo') {
    iconoSemaforo = 'semaforo-2';
  } else if (nombreSemaforo == 'verde') {
    iconoSemaforo = 'semaforo-1';
  }

  return Container(
      padding: EdgeInsets.only(bottom: 8.sp, top: 11.sp),
      decoration: BoxDecoration(
        border: semaforo != true
            ? Border(
                bottom: BorderSide(
                  width: 0.3.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            : Border(
                bottom: BorderSide(width: 0.0, color: Colors.white),
              ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 120.sp,
            child: Text(
              '$txtPrimero',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Visibility(
            visible: semaforo,
            child: Container(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/img/Desglose/Home/$iconoSemaforo.png',
                    height: 19.0.sp,
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Visibility(
            visible: !semaforo,
            child: Container(
                height: 24.sp,
                width: 80.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$txtSegundo',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
          ),
          Spacer(),
          // semaforo == false
          //     ? Expanded(
          //         child: Container(
          //           child: Text(
          //             '$txtTercero',
          //             style: TextStyle(
          //               fontSize: 13.sp,
          //               color: Color(0xff808080),
          //               fontWeight: FontWeight.w400,
          //             ),
          //             textAlign: TextAlign.start,
          //           ),
          //         ),
          //       )
          //     : Expanded(
          //         child: Text(''),
          //       )
        ],
      ));
}
