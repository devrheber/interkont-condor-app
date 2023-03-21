import 'package:flutter/material.dart';

class BuildSizedBox extends StatelessWidget {
  const BuildSizedBox({
    Key? key,
    this.height = 0.0,
    this.width = 0.0,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
