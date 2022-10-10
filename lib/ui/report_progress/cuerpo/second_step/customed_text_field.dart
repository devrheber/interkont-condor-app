import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

class CustomedTextField extends StatelessWidget {
  const CustomedTextField({
    Key key,
    @required this.title,
    @required this.hintText,
    @required this.onChanged,
    @required this.controller,
  }) : super(key: key);

  final String title;
  final String hintText;
  final Function onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 93.sp,
      margin: EdgeInsets.only(top: 8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 16.57.sp),
              // Container(
              //   child: logros
              //       ? Image.asset(
              //           'assets/img/Desglose/ReporteAvance/icn-logros.png',
              //           width: 24.0.sp,
              //         )
              //       : Image.asset(
              //           'assets/img/Desglose/ReporteAvance/icn-dificultades.png',
              //           width: 24.0.sp,
              //         ),
              // ),
              Container(
                child: Image.asset(
                  'assets/new/home/logro.png',
                  width: 24.0.sp,
                  height: 24.0.sp,
                ),
              ),
              SizedBox(width: 9.47.sp),
              Expanded(
                  child: Text(
                '$title',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 13.23.sp,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w300,
                ),
              ))
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 14.0.sp, left: 17.sp, right: 17.sp),
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: controller,
              onChanged: onChanged,
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: Color(0xff556A8D),
              ),
              decoration: InputDecoration.collapsed(
                hintText: "$hintText",
                hintStyle: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: Color(0xff556A8D).withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
