import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    required this.text,
    required this.number,
    this.isCompleted = false,
    this.completedColor = const Color(0xFF52B4A6),
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
          duration: const Duration(milliseconds: 1400),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: isCompleted
                      ? const Color(0xFF52B4A6)
                      : Colors.transparent),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 4.0),
                  decoration: BoxDecoration(
                    color: circleBgColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                  ),
                  child: Text(
                    number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 14.61,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
              Text(
                text,
                textAlign: TextAlign.center,
                style: style ??
                    const TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 12,
                      color: Color(0xff556A8D),
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
