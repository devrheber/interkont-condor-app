import 'package:appalimentacion/utils/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImg extends StatelessWidget {
  const LogoImg({
    Key key,
    this.assetImageRoute = Assets.assetsNewSplashLogoAnimated,
    this.width = 142.0,
    this.height = 142.0,
  }) : super(key: key);

  final String assetImageRoute;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Image.asset(assetImageRoute, width: width.sp, height: height.sp),
    );
  }
}

class FooterImg extends StatelessWidget {
  const FooterImg({
    Key key,
    this.assetImageRoute = Assets.assetsNewLoginFooter,
    this.width = 142.0,
    this.height = 142.0,
  }) : super(key: key);
  final String assetImageRoute;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "footer",
      child: Image.asset(assetImageRoute, width: width.sp, height: height.sp),
    );
  }
}
