import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../globales/colores.dart';

class FifthStepCard extends StatelessWidget {
  const FifthStepCard({
    Key? key,
    required this.title,
    required this.colorTitle,
    required this.children,
  }) : super(key: key);

  final String title;
  final Color colorTitle;
  final List<FifthStepCardDetail> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: 22.sp, left: 23.sp, right: 22.0.sp, bottom: 25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: colorTitle,
              ),
            ),
            ...children
          ],
        ),
      ),
    );
  }
}

class FifthStepCardDetail extends StatelessWidget {
  const FifthStepCardDetail({
    Key? key,
    required this.title,
    this.value,
    this.child,
    this.showDivider = true,
  }) : super(key: key);

  final String title;
  final String? value;
  final Widget? child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    assert(value == null || child == null);

    return Container(
      padding: EdgeInsets.only(bottom: 8.sp, top: 11.sp),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: showDivider ? 0.3.sp : 0.0,
          color: Colors.black.withOpacity(0.5),
        ),
      )),
      child: Row(
        children: <Widget>[
          Container(
            width: 120.sp,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (child != null) child!,
          Spacer(),
          if (value != null)
            Container(
              height: 24.sp,
              width: 80.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    value!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          Spacer(),
        ],
      ),
    );
  }
}

class TrafficLight extends StatelessWidget {
  const TrafficLight({Key? key, required this.icon}) : super(key: key);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/img/Desglose/Home/$icon.png',
            height: 19.0.sp,
          )
        ],
      ),
    );
  }
}
