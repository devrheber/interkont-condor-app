import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customedAppBar(
    {dynamic onPressed,
    String title = "",
    bool last = false,
    bool stop = false}) {
  return Container(
    width: double.infinity,
    height: last ? 100.sp : 60.sp,
    margin: stop
        ? EdgeInsets.only()
        : EdgeInsets.only(right: 14.sp, left: 14.sp, top: 50.h),
    child: Column(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                  onPressed: onPressed,
                ),
                last
                    ? Container()
                    : Text(
                        title,
                        style: TextStyle(
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
            last
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: "montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        last
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No finalices sin antes estar seguro\nde tus nuevos cambios",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    ),
  );
}
