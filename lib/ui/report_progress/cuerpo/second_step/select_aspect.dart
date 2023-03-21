import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';

const titleColor = Color(0xff384C68);

class SelectAspect extends StatelessWidget {
  const SelectAspect({
    Key? key,
    required this.aspectSelected,
    required this.aspectsToEvaluate,
    required this.onChanged,
  }) : super(key: key);

  final AspectoEvaluar aspectSelected;
  final List<AspectoEvaluar> aspectsToEvaluate;
  final void Function(AspectoEvaluar) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 43,
      margin: const EdgeInsets.only(top: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 16.57),
          Container(
            child: _IconImage(text: aspectSelected.descripcionAspectoEvaluar),
          ),
          const SizedBox(width: 9.47),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconSize: 16.74,
                hint: Text(
                  '${aspectSelected.descripcionAspectoEvaluar}',
                  style: const TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 13.22,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff384C68),
                  ),
                ),
                items: aspectsToEvaluate
                    .map((value) => DropdownMenuItem(
                          child: Row(
                            children: <Widget>[
                              _IconImage(text: value.descripcionAspectoEvaluar),
                              const SizedBox(width: 9.47),
                              Text(
                                value.descripcionAspectoEvaluar,
                                style: const TextStyle(
                                  fontFamily: "montserrat",
                                  fontSize: 13.22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff384C68),
                                ),
                              ),
                            ],
                          ),
                          value: value,
                        ))
                    .toList(),
                onChanged: (AspectoEvaluar? value) {
                  if (value == null) return;
                  onChanged(value);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _IconImage extends StatelessWidget {
  const _IconImage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    String icon = 'icn-al-1.png';
    if (text == 'Administrativo') icon = 'icn-al-1.png';
    if (text == 'Financiero') icon = 'icn-al-2.png';
    if (text == 'Técnico') icon = 'icn-al-3.png';
    if (text == 'Jurídico') icon = 'icn-al-4.png';
    if (text == 'Social') icon = 'icn-al-5.png';
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/$icon'),
      width: 24,
      height: 24,
    );
  }
}
