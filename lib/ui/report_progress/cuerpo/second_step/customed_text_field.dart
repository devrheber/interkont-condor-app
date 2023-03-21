import 'package:flutter/material.dart';

import '../../../../globales/colores.dart';

const titleColor = Color(0xff444444);

class CustomedTextField extends StatelessWidget {
  const CustomedTextField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String title;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 93,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 16.57),
              // Container(
              //   child: logros
              //       ? Image.asset(
              //           'assets/img/Desglose/ReporteAvance/icn-logros.png',
              //           width: 24.0,
              //         )
              //       : Image.asset(
              //           'assets/img/Desglose/ReporteAvance/icn-dificultades.png',
              //           width: 24.0,
              //         ),
              // ),
              Container(
                child: Image.asset(
                  'assets/new/home/logro.png',
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              const SizedBox(width: 9.47),
              Expanded(
                  child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 13.23,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w300,
                ),
              ))
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 14.0, left: 17, right: 17),
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: controller,
              onChanged: onChanged,
              maxLines: 2,
              style: const TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0xff556A8D),
              ),
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: const Color(0xff556A8D).withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
