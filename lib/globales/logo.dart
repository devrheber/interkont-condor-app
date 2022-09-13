import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImg extends StatelessWidget {
  const LogoImg({
    Key key,
    this.assetImageRoute = 'assets/new/splash/logo.gif',
    this.width = 142.0,
    this.height = 142.0,
  }) : super(key: key);

  final String assetImageRoute;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: "logo",
        child: Image.asset(assetImageRoute, width: width.sp, height: height.sp),
      ),
    );
  }
}


class FooterImg extends StatelessWidget {
  const FooterImg({
    Key key,
    this.assetImageRoute = 'assets/new/login/footer.png',
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
