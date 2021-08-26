import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/quintoPaso/cardContenido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

var proyectos =    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado];

var valorejecutado =   proyectos['valorejecutado'] == null ? 0 : proyectos['valorejecutado'];
var valorproyecto =    proyectos['valorproyecto'] == null ? 0 : proyectos['valorproyecto'];

var nuevoValorEjecutado = proyectos['datos']['nuevoValorEjecutado'] == null    ? 0    : proyectos['datos']['nuevoValorEjecutado'];

var porcentajeProyectado = proyectos['porcentajeProyectado'] == null    ? 0    : proyectos['porcentajeProyectado'];

var porcentajeValorProyectadoSeleccionado =  proyectos['datos']['porcentajeValorProyectadoSeleccionado'] == null      ? 0     : proyectos['datos']['porcentajeValorProyectadoSeleccionado'];

@override
class CardCuerpoQuintoPaso extends StatelessWidget {
  Widget build(BuildContext context) {
    NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
    NumberFormat f2 = new NumberFormat("#,##0.00", "es_AR");
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 164.h, left: 20.sp, right: 20.sp),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              cardContenidoQuintoPaso(
                context,
                'Antes',
                'Asi va',
                porcentajeAsiVa(f),
                porcentajeAsiVaDos(),
                dineroAsiVa(f2),
                'Deberia ir',
                porcentajeDeberiaIr(f),
                dineroDeberiaIr(f2),
                true,
                '',
              ),
              SizedBox(
                height: 12.sp,
              ),
              cardContenidoQuintoPaso(
                context,
                'Ahora',
                'Asi va en',
                porcentajeAsiVaEn(f),
                porcentajeAsiVaEnDos(),
                dineroAsiVaEn(f2),
                'Deberia ir en',
                porcentajeDeberiaIrEn(f),
                dineroDeberiaIrEn(f2),
                false,
                '',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String dineroDeberiaIrEn(NumberFormat f2) =>      '${f2.format((porcentajeValorProyectadoSeleccionado / 100) * valorproyecto)}';

  String porcentajeDeberiaIrEn(NumberFormat f) =>      '${f.format(porcentajeValorProyectadoSeleccionado)}';

  String dineroAsiVaEn(NumberFormat f2) => '${f2.format(nuevoValorEjecutado)}';

  String porcentajeAsiVaEnDos() =>      '${((nuevoValorEjecutado / valorproyecto) * 100)}';

  String dineroDeberiaIr(NumberFormat f2) => '${f2.format((porcentajeProyectado / 100) * valorproyecto)}';

  String porcentajeDeberiaIr(NumberFormat f) => '${f.format(porcentajeProyectado)}';

  String dineroAsiVa(NumberFormat f2) => '${f2.format(valorejecutado)}';

  String porcentajeAsiVaDos() => '${((100 * (valorejecutado / valorproyecto)).round())}';

  String porcentajeAsiVa(NumberFormat f) => '${f.format((100 * (valorejecutado / valorproyecto)).round())}';

  String porcentajeAsiVaEn(NumberFormat f) => '${f.format((nuevoValorEjecutado / valorproyecto) * 100)}';
}
