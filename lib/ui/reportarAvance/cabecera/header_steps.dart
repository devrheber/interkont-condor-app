import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

class HeaderSteps extends StatelessWidget {
  const HeaderSteps({Key key, this.pasoSeleccionado}) : super(key: key);

  final int pasoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90.h,
      margin: EdgeInsets.only(top: 164.h, right: 28.sp, left: 28.sp),
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Step(
            text: 'Ingrese el avance',
            number: '1',
            isCompleted: (pasoSeleccionado >= 1),
          ),
          Step(
            text: 'Avance cualitativo',
            number: '2',
            isCompleted: (pasoSeleccionado >= 2),
          ),
          Step(
            text: 'Indicador de alcance',
            number: '3',
            isCompleted: (pasoSeleccionado >= 3),
          ),
          Step(
            text: 'Descripción & Documentos',
            number: '4',
            isCompleted: (pasoSeleccionado >= 4),
          )
        ],
      ),
    );
  }
}

class Step extends StatelessWidget {
  const Step({
    Key key,
    @required this.text,
    @required this.number,
    this.isCompleted = false,
  }) : super(key: key);

  final String text;
  final String number;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    Color circleBgColor;
    if (isCompleted) {
      circleBgColor = Color(0xff745FF2);
    } else {
      circleBgColor = Color(0xff556A8D);
    }

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1400),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.0,
                color: isCompleted ? Color(0xff7964F3) : Colors.transparent),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 4.0.sp),
                decoration: BoxDecoration(
                  color: circleBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                ),
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 14.61.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                )),
            Container(
              child: Text(
                '$text',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontSize: 12.sp,
                  color: Color(0xff556A8D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
