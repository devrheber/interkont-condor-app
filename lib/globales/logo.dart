import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLogoImg(
    {String assetImageRoute = "assets/new/splash/logo.gif",
    double width = 142.0,
    double height = 142}) {
  return Container(
    child: Hero(
      tag: "logo",
      child: Image.asset(assetImageRoute, width: width.sp, height: height.sp),
    ),
  );
}

Widget buildFooterImg(
    {String assetImageRoute = "assets/new/login/footer.png",
    double width = 142.0,
    double height = 142}) {
  return Container(
    child: Hero(
      tag: "footer",
      child: Image.asset(assetImageRoute, width: width.sp, height: height.sp),
    ),
  );
}
