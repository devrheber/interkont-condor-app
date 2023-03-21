import 'package:flutter/material.dart';

import '../utils/assets/assets.dart';

class LogoImg extends StatelessWidget {
  const LogoImg({
    Key? key,
    this.assetImageRoute = 'assets/Siente/new_logo.png',
    this.width = 253.51,
    this.height = 218.65,
  }) : super(key: key);

  final String assetImageRoute;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetImageRoute,
      width: width,
      height: height,
    );
  }
}

class FooterImg extends StatelessWidget {
  const FooterImg({
    Key? key,
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
      child: Image.asset(assetImageRoute, width: width, height: height),
    );
  }
}
