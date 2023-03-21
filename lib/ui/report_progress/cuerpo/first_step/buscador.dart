import 'package:flutter/material.dart';

import '../../../../theme/color_theme.dart';

const titleColor = Color(0xff444444);

Widget buscador({dynamic onChanged, dynamic onPressed}) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 35.77,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 11.23),
              Image.asset("assets/new/home/search.png",
                  height: 12.08, width: 12.03),
              const SizedBox(width: 8.23),
              Expanded(
                child: Container(
                  width: 237.57,
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w500,
                      color: Color(0xff566B8C),
                    ),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Buscar por palabra clave...",
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w500,
                        color: Color(0xff556a8d),
                      ),
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
      const SizedBox(width: 7.73),
      Expanded(
        child: Container(
          height: 35.77,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: RaisedButton(
            elevation: 0,
            onPressed: onPressed,
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: ColorTheme.buttonGradient,
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Buscar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
