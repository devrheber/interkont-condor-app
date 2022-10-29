import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurpleRoundedGradientContainer extends StatelessWidget {
  const PurpleRoundedGradientContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff666666).withOpacity(0.26),
              blurRadius: 14.sp,
              spreadRadius: 0.4.sp,
              offset: Offset(4.sp, 10.sp)),
        ],
        borderRadius: BorderRadius.circular(16.13.sp),
        gradient: ColorTheme.cardGradient,
      ),
      padding: EdgeInsets.only(
        left: 15.sp,
        right: 15.sp,
        top: 20.45.sp,
        bottom: 20.45.sp,
      ),
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      child: child,
    );
  }
}
