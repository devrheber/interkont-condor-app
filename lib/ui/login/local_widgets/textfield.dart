import 'package:flutter/material.dart';

import '../../../globales/sized_box.dart';

class CustomedTextField extends StatelessWidget {
  const CustomedTextField({
    Key? key,
    this.onChanged,
    this.fontSize = 13.0,
    this.height = 50,
    this.width = 350,
    required this.imageIcon,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final double fontSize;
  final double height;
  final double width;
  final String imageIcon;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 11),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            const BuildSizedBox(width: 21.92),
            Container(
              child: Image(
                image: AssetImage(imageIcon),
                width: 19.17,
                height: 19.17,
              ),
            ),
            const BuildSizedBox(width: 21.92),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                onChanged: onChanged,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize,
                      color: Colors.white),
                ),
              ),
            ),
            const BuildSizedBox(width: 21.92),
          ],
        ));
  }
}
