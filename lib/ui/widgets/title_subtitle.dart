import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextSubtitle2 extends StatelessWidget {
  const TextSubtitle2({Key? key, required this.text, this.isRequired = false})
      : super(key: key);
  final String text;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    var newText = text;
    if (isRequired) {
      newText = '$text (Obligatorio)';
    }
    return Text(
      // 'Ingrese cantidad de avance por actividad $otros',
      newText,
      style: TextStyle(
        fontFamily: 'montserrat',
        fontSize: 14.sp,
        color: Color(0xFF556A8D),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      // 'Ingrese cantidad de avance por actividad $otros',
      text,
      style: TextStyle(
        fontFamily: 'montserrat',
        fontSize: 15.sp,
        color: Color(0xFF566B8C),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'montserrat',
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
