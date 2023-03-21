import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';


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
              color: const Color(0xff666666).withOpacity(0.26),
              blurRadius: 14,
              spreadRadius: 0.4,
              offset: const Offset(4, 10)),
        ],
        borderRadius: BorderRadius.circular(16.13),
        gradient: ColorTheme.cardGradient,
      ),
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20.45,
        bottom: 20.45,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: child,
    );
  }
}
