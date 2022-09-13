import 'package:appalimentacion/globales/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomedTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final double fontSize;
  final double height;
  final double width;
  final String imageIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  const CustomedTextField({
    Key key,
    this.onChanged,
    this.fontSize = 13.0,
    this.height = 50,
    this.width = 350,
    this.imageIcon,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            BuildSizedBox(width: 21.92),
            Container(
              child: Image(
                image: AssetImage(imageIcon),
                width: 19.17.w,
                height: 19.17.w,
              ),
            ),
            BuildSizedBox(width: 21.92),
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
                  fontSize: fontSize.sp,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize.sp,
                      color: Colors.white),
                ),
              ),
            ),
            BuildSizedBox(width: 21.92),
          ],
        ));
  }
}
