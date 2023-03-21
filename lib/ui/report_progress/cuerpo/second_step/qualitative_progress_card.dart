import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';

class QualitativeProgressCard extends StatelessWidget {
  const QualitativeProgressCard({
    Key? key,
    required this.item,
    required this.deleteMethod,
  }) : super(key: key);

  final QualitativeProgress item;
  final VoidCallback deleteMethod;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontFamily: 'montserrat',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: const Color(0xff556a8d),
    );
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(
        left: 18.26,
        right: 14.76,
        top: 18.48,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  '${item.title}',
                  style: const TextStyle(
                    color: const Color(0xff334660),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.61,
                    fontFamily: 'montserrat',
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: deleteMethod,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        'Eliminar',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(0xffC1272D),
                          fontWeight: FontWeight.w300,
                          fontSize: 10.32,
                          fontFamily: 'montserrat',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5.0),
                        width: 23.53,
                        child: Image.asset(
                          'assets/img/Desglose/Demas/btn-delete.png',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'LOGROS',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                SelectableText(
                  item.getAchive,
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '\nDIFICULTADES',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                SelectableText(
                  item.getDifficulty,
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
