import 'package:flutter/material.dart';

import '../../../../../globales/colores.dart';

Widget factorRegistrado(int posicion, String tipo, String factor, onPressed) {
  return FactorRegistrado();
}

class FactorRegistrado extends StatelessWidget {
  const FactorRegistrado({
    Key key,
    this.posicion,
    this.tipo,
    this.factor,
    this.description,
    this.onTap,
  }) : super(key: key);
  final int posicion;
  final String tipo;
  final String factor;
  final String description;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.1),
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
                Padding(
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
          SizedBox(
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
    Key key,
    this.title,
    this.text,
  }) : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              title,
              style: AppTheme.parrafoBlancoNegrita,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text( 
            text,
            style: AppTheme.parrafoBlanco,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
