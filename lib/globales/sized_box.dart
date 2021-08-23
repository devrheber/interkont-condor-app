import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSizedBox({
  double height: 0.0,
  double width: 0.0,
}) {
  return SizedBox(
    height: height.sp,
    width: width.sp,
  );
}
