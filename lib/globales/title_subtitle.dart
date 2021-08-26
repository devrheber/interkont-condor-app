import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Text buildTextSubtitle2({@required String text}) {
  return Text(
    // 'Ingrese cantidad de avance por actividad $otros',
    text,
    style: TextStyle(
      fontFamily: 'montserrat',
      fontSize: 14.sp,
      color: Color(0xFF556A8D),
      fontWeight: FontWeight.w400,
    ),
  );
}
Text buildTextSubtitle({@required String text}) {
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

Text buildTextTitle({@required String text}) {
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
