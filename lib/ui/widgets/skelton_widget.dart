import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(const Radius.circular(16)),
      ),
    );
  }
}
