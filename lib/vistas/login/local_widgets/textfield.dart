import 'package:appalimentacion/globales/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCustomedTextfield({
  @required dynamic onChanged,
  double fontSize = 13.0,
  double height: 50,
  double width: 350,
  @required String imageIcon,
  @required String hintText,
  bool obscureText = false,
  keyboardType = TextInputType.text,
}) {
  return Container(
      width: width.sp,
      height: height.sp,
      margin: EdgeInsets.only(top: 11.sp),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          buildSizedBox(width: 21.92),
          Container(
            child: Image(
              image: AssetImage(imageIcon),
              width: 19.17.w,
              height: 19.17.w,
            ),
          ),
          buildSizedBox(width: 21.92),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.bold,
                fontSize: fontSize.sp,
              ),
              onChanged: onChanged,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize.sp,
                    color: Colors.white),
              ),
            ),
          ),
          buildSizedBox(width: 21.92),
        ],
      ));
}
