import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/listaProyectos/project_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../globales/colores.dart';

// Widget seleccionaPeriodo(context, int posicionPeriodoReportado,
//     int idPeriodoSeleccionado, valores, accion) {

// Widget seleccionaPeriodo(
//     {context,
//     int posicionPeriodoReportado,
//     int idPeriodoSeleccionado,
//     List<Periodo> valores,
//     accion}) {
//   List<int> nuevosValores = [];
//   for (int cont = 0; cont < valores.length; cont++) {
//     nuevosValores.add(cont);
//     // if (valores[cont]['periodoId'] == idPeriodoSeleccionado) {
//     if (valores[cont].periodoId == idPeriodoSeleccionado) {
//       accion(cont);
//     }
//   }

//   return Container(
//     width: double.infinity,
//     height: 58.0.sp,
//     margin: EdgeInsets.only(
//       bottom: 10.0,
//       right: 28.sp,
//       left: 28.sp,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.all(Radius.circular(30)),
//       border: Border(
//         top: BorderSide(width: 0.5, color: AppTheme.cuarto),
//         left: BorderSide(width: 0.5, color: AppTheme.cuarto),
//         right: BorderSide(width: 0.5, color: AppTheme.cuarto),
//         bottom: BorderSide(width: 0.5, color: AppTheme.cuarto),
//       ),
//     ),
//     padding: EdgeInsets.all(10.0),
//     child: Row(
//       children: <Widget>[
//         Expanded(
//             flex: 1,
//             child: Image.asset(
//               'assets/img/Desglose/Home/icn-reloj.png',
//               height: 17.82.sp,
//               width: 17.82.sp,
//             )),
//         Expanded(
//           flex: 6,
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//                 hint: Padding(
//                   padding: EdgeInsets.only(left: 10.0),
//                   child: Row(
//                     children: <Widget>[
//                       Text('del ', style: AppTheme.preposition),
//                       // Text('$fechaIniPeriodo', style: AppTheme.dates),
//                       Text(' hasta el ', style: AppTheme.preposition),
//                       // Text('$fechaFinPeriodo', style: AppTheme.dates),
//                     ],
//                   ),
//                 ),
//                 items: nuevosValores
//                     .map((value) => DropdownMenuItem(
//                           child: Row(
//                             children: <Widget>[
//                               Text('del ', style: AppTheme.parrafo),
//                               Text(valores[value].fechaIniPeriodo,
//                                   style: AppTheme.parrafoNegrita),
//                               Text(' hasta el ', style: AppTheme.parrafo),
//                               Text(valores[value].fechaFinPeriodo,
//                                   style: AppTheme.parrafoNegrita),
//                             ],
//                           ),
//                           value: value,
//                         ))
//                     .toList(),
//                 onChanged: accion),
//           ),
//         )
//       ],
//     ),
//   );
// }

class DropDownPeriodo extends StatelessWidget {
  const DropDownPeriodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index =
        context.watch<ProjectDetailProvider>().posicionPeriodoReportado;
    final detailProvider =
        Provider.of<ProjectDetailProvider>(context, listen: false);

    final fechaInicio = detailProvider.detail.periodos[index].fechaIniPeriodo;
    final fechaFin = detailProvider.detail.periodos[index].fechaFinPeriodo;

    return Container(
      width: double.infinity,
      height: 58.0.sp,
      margin: EdgeInsets.only(
        bottom: 10.0,
        right: 28.sp,
        left: 28.sp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(width: 0.5, color: AppTheme.cuarto),
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Image.asset(
                'assets/img/Desglose/Home/icn-reloj.png',
                height: 17.82.sp,
                width: 17.82.sp,
              )),
          Expanded(
            flex: 6,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text('del ', style: AppTheme.preposition),
                        Text(fechaInicio, style: AppTheme.dates),
                        Text(' hasta el ', style: AppTheme.preposition),
                        Text(fechaFin, style: AppTheme.dates),
                      ],
                    ),
                  ),
                  items: detailProvider.detail.periodos
                      .map((value) => DropdownMenuItem(
                            child: Row(
                              children: <Widget>[
                                Text('del ', style: AppTheme.parrafo),
                                Text(value.fechaIniPeriodo,
                                    style: AppTheme.parrafoNegrita),
                                Text(' hasta el ', style: AppTheme.parrafo),
                                Text(value.fechaFinPeriodo,
                                    style: AppTheme.parrafoNegrita),
                              ],
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (Periodo periodo) {
                    int index = detailProvider.detail.periodos.indexOf(periodo);

                    if (index >= 0) {
                      detailProvider.cambiarPosicionPeriodoReportado(index);
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
