import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../globales/variables.dart';
import 'cardContenido.dart';

var proyectos =
    contenidoWebService[0]['proyectos'][posListaProySelec];

var valorejecutado =
    proyectos['valorejecutado'] == null ? 0 : proyectos['valorejecutado'];
var valorproyecto =
    proyectos['valorproyecto'] == null ? 0 : proyectos['valorproyecto'];

var nuevoValorEjecutado = proyectos['datos']['nuevoValorEjecutado'] == null
    ? 0
    : proyectos['datos']['nuevoValorEjecutado'];

var porcentajeProyectado = proyectos['porcentajeProyectado'] == null
    ? 0
    : proyectos['porcentajeProyectado'];

var porcentajeValorProyectadoSeleccionado =
    proyectos['datos']['porcentajeValorProyectadoSeleccionado'] == null
        ? 0
        : proyectos['datos']['porcentajeValorProyectadoSeleccionado'];

NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
NumberFormat f2 = new NumberFormat("#,##0.00", "es_AR");

@override
class CardCuerpoQuintoPaso extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 164.h, left: 20.sp, right: 20.sp),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              cardContenidoQuintoPaso(
                titulo: 'Antes',
                asivaTxt: 'Asi va',
                porcentajeAsiVa: porcentajeAsiVa(),
                porcentajeAsiVaDos: porcentajeAsiVaDos(),
                dineroAsiVa: dineroAsiVa(),
                deberiaIrTxt: 'Deberia ir',
                porcentajeDeberiaIr: porcentajeDeberiaIr(),
                dineroDeberiaIr: dineroDeberiaIr(),
                esAntes: true,
                semaforo: '',
              ),
              SizedBox(
                height: 12.sp,
              ),
              cardContenidoQuintoPaso(
                titulo: 'Ahora',
                asivaTxt: 'Asi va en',
                porcentajeAsiVa: porcentajeAsiVaEn(),
                porcentajeAsiVaDos: porcentajeAsiVaEnDos(),
                dineroAsiVa: dineroAsiVaEn(),
                deberiaIrTxt: 'Deberia ir en',
                porcentajeDeberiaIr: porcentajeDeberiaIrEn(),
                dineroDeberiaIr: dineroDeberiaIrEn(),
                esAntes: false,
                semaforo: '',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String dineroDeberiaIrEn() =>
      '${f2.format((porcentajeValorProyectadoSeleccionado / 100) * valorproyecto)}';

  String porcentajeDeberiaIrEn() =>
      '${f.format(porcentajeValorProyectadoSeleccionado)}';

  String dineroAsiVaEn() => '${f2.format(nuevoValorEjecutado)}';

  String porcentajeAsiVaEnDos() =>
      '${((nuevoValorEjecutado / valorproyecto) * 100)}';

  String dineroDeberiaIr() =>
      '${f2.format((porcentajeProyectado / 100) * valorproyecto)}';

  String porcentajeDeberiaIr() => '${f.format(porcentajeProyectado)}';

  String dineroAsiVa() => '${f2.format(valorejecutado)}';

  String porcentajeAsiVaDos() =>
      '${((100 * (valorejecutado / valorproyecto)).round())}';

  String porcentajeAsiVa() =>
      '${f.format((100 * (valorejecutado / valorproyecto)).round())}';

  String porcentajeAsiVaEn() =>
      '${f.format((nuevoValorEjecutado / valorproyecto) * 100)}';
}
