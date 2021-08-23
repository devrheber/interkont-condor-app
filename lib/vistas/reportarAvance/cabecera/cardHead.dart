import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

Widget pasos({int pasoSeleccionado}) {
  // pasoSeleccionado = 1;
  return Container(
      width: double.infinity,
      height: 76.h,
      margin: EdgeInsets.only(top: 164.h, right: 28.sp, left: 28.sp),
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: Row(
        children: <Widget>[
          paso(
            texto: 'Ingrese el avance',
            index: 1,
            paso: pasoSeleccionado,
          ),
          paso(
            texto: 'Avance cualitativo',
            index: 2,
            paso: pasoSeleccionado,
          ),
          paso(
            texto: 'Indicador de alcance',
            index: 3,
            paso: pasoSeleccionado,
          ),
          paso(
            texto: 'Descripción & Documentos',
            index: 4,
            paso: pasoSeleccionado,
          )
        ],
      ));
}

Widget paso({String texto, int index, int paso}) {
  Color circleBgColor = Colors.white;
  Color textColor = Color(0xff556A8D);

  FontWeight fontWeight = FontWeight.w700;

  if (index <= paso) {
    circleBgColor = Color(0xff745FF2);
  } else {
    circleBgColor = Color(0xff556A8D);
  }

  if (index == paso) {
    textColor = Colors.black;
  }

  return Expanded(
      child: AnimatedContainer(
    duration: Duration(milliseconds: 1400),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
            width: 1.0,
            color: index <= paso ? Color(0xff7964F3) : Colors.transparent),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedContainer(
            duration: Duration(milliseconds: 1400),
            width: 28.w,
            height: 28.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 4.0.sp),
            decoration: BoxDecoration(
              color: circleBgColor,
              borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
            ),
            child: Text(
              '$index',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "montserrat",
                fontSize: 13.61.sp,
                color: Colors.white,
                fontWeight: fontWeight,
              ),
            )),
        Container(
          width: 66.w,
          child: Text(
            '$texto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "montserrat",
              fontSize: 10.sp,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    ),
  ));
}
