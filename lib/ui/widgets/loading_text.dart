import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingText extends StatefulWidget {
  const LoadingText(this.text, {Key key}) : super(key: key);

  final String text;

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          widget.text,
          speed: const Duration(milliseconds: 150),
          textStyle: TextStyle(
            fontFamily: 'montserrat',
            fontSize: 14.sp,
            color: Color(0xFF556A8D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
      isRepeatingAnimation: true,
      repeatForever: true,
      displayFullTextOnTap: true,
      stopPauseOnTap: false,
    );
  }
}
