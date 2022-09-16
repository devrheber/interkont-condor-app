import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/color_theme.dart';

final titleColor = Color(0xff444444);

Widget buscador( {dynamic onChanged, dynamic onPressed}) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 35.77.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 11.23.w),
              Image.asset("assets/new/home/search.png",
                  height: 12.08.h, width: 12.03.h),
              SizedBox(width: 8.23.w),
              Expanded(
                child: Container(
                  width: 237.57.sp,
                  child: TextField(
                      textInputAction: TextInputAction.send,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w500,
                        color: Color(0xff566B8C),
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: "Buscar por palabra clave...",
                        hintStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.w500,
                          color: Color(0xff556a8d),
                        ),
                      ),
                      onChanged: onChanged),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 7.73.w),
      Expanded(
        child: Container(
          height: 35.77.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: RaisedButton(
            elevation: 0,
            onPressed: onPressed,
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: ColorTheme.buttonGradient,
              ),
              child: Container(
                // constraints: BoxConstraints(maxWidth: 250.0, minHeight: 20.0),

                alignment: Alignment.center,
                child: Text(
                  "Buscar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
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
