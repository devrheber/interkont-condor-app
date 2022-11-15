import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    required this.text,
    required this.number,
    this.isCompleted = false,
    this.completedColor = const Color(0xff745FF2),
    this.pendingColor = const Color(0xff556A8D),
    this.style,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String number;
  final bool isCompleted;
  final Color completedColor;
  final Color pendingColor;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color circleBgColor;
    if (isCompleted) {
      circleBgColor = completedColor;
    } else {
      circleBgColor = pendingColor;
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1400),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: isCompleted ? Color(0xff7964F3) : Colors.transparent),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 28.w,
                  height: 28.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 4.0.sp),
                  decoration: BoxDecoration(
                    color: circleBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                  ),
                  child: Text(
                    number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 14.61.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
              Container(
                child: Text(
                  '$text',
                  textAlign: TextAlign.center,
                  style: style ??
                      TextStyle(
                        fontFamily: "montserrat",
                        fontSize: 12.sp,
                        color: Color(0xff556A8D),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
