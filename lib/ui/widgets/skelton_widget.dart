import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
    );
  }
}
