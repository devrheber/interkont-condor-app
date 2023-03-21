import 'package:flutter/material.dart';

import '../../../../../domain/models/models.dart';
import '../../../../../globales/colores.dart';
import '../../../../../theme/color_theme.dart';

// Widget campoSeleccionar(
//     String txtHint,
//     String nombreObj,
//     int posicionPeriodoReportado,
//     idTipoFactorAtrasoSeleccionado,
//     bool esFactorAtraso,
//     valores,
//     accion) {
//   List<int> nuevosValores = [];
//   for (int cont = 0; cont < valores.length; cont++) {
//     if (esFactorAtraso == true) {
//       if (valores[cont]['tipoFactorAtrasoId'] ==
//           idTipoFactorAtrasoSeleccionado) {
//         nuevosValores.add(cont);
//       }
//     } else {
//       nuevosValores.add(cont);
//     }
//   }
//   return Container(
//     padding: EdgeInsets.only(left: 10.0, right: 10.0),
//     margin: EdgeInsets.only(bottom: 5.0),
//     decoration: BoxDecoration(
//       color: Color.fromRGBO(1, 1, 1, 0.1),
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//     ),
//     child: DropdownButtonHideUnderline(
//       child: DropdownButton(
//           iconEnabledColor: Colors.white,
//           isExpanded: true,
//           hint: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Row(
//                 children: <Widget>[
//                   Text('$txtHint', style: AppTheme.parrafoBlanco),
//                 ],
//               )),
//           items: nuevosValores
//               .map((value) => DropdownMenuItem(
//                     child: Text(valores[value][nombreObj]),
//                     value: value,
//                   ))
//               .toList(),
//           onChanged: accion),
//     ),
//   );
// }

class SelectTypeDelayFactor extends StatelessWidget {
  const SelectTypeDelayFactor({
    Key? key,
    required this.hintText,
    required this.list,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String hintText;
  final List<TiposFactorAtraso> list;
  final TiposFactorAtraso? value;

  // valores,
  final void Function(TiposFactorAtraso?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(1, 1, 1, 0.1),
        borderRadius: const BorderRadius.all(const Radius.circular(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TiposFactorAtraso>(
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          dropdownColor: ColorTheme.primaryTint,
          isExpanded: true,
          hint: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Text('$hintText', style: AppTheme.parrafoBlanco),
                ],
              )),
          value: value,
          items: list
              .map((value) => DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(value.tipoFactorAtraso),
                    ),
                    value: value,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class SelectDelayFactor extends StatelessWidget {
  const SelectDelayFactor({
    Key? key,
    required this.hintText,
    required this.list,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String hintText;
  final List<FactoresAtraso> list;
  final void Function(FactoresAtraso?)? onChanged;
  final FactoresAtraso? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(1, 1, 1, 0.1),
        borderRadius: BorderRadius.all(const Radius.circular(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<FactoresAtraso>(
            iconEnabledColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            dropdownColor: ColorTheme.primaryTint,
            isExpanded: true,
            hint: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text('$hintText', style: AppTheme.parrafoBlanco),
                  ],
                )),
            value: value,
            items: list
                .map((value) => DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          value.factorAtraso,
                        ),
                      ),
                      value: value,
                    ))
                .toList(),
            onChanged: onChanged),
      ),
    );
  }
}
