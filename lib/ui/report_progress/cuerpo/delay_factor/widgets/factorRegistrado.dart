import 'package:flutter/material.dart';

import '../../../../../globales/colores.dart';


// Widget factorRegistrado(int posicion, String tipo, String factor, onPressed) {
//   return FactorRegistrado();
// }

class FactorRegistrado extends StatelessWidget {
  const FactorRegistrado({
    Key? key,
    required this.posicion,
    required this.tipo,
    required this.factor,
    required this.description,
    required this.onTap,
  }) : super(key: key);
  final int posicion;
  final String tipo;
  final String factor;
  final String description;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Factor ${posicion + 1}',
                      style: AppTheme.parrafoBlancoNegrita),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text(
                    'Eliminar',
                    style: AppTheme.parrafoBlanco,
                  ),
                ),
                Image.asset(
                  'assets/img/Desglose/Demas/btn-delete.png',
                  width: 25.0,
                  height: 25.0,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          _FactorWidget(title: 'Tipo', text: tipo),
          _FactorWidget(title: 'Factor', text: factor),
          _FactorWidget(title: 'Descripción', text: description),
        ],
      ),
    );
  }
}

class _FactorWidget extends StatelessWidget {
  const _FactorWidget({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                title,
                style: AppTheme.parrafoBlancoNegrita,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: AppTheme.parrafoBlanco,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
