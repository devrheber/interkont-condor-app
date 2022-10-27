import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerButton extends StatelessWidget {
  const ShimmerButton({
    Key? key,
    this.delay = Duration.zero,
  }) : super(key: key);

  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return ShinyAnimation(
      color: Colors.black.withOpacity(0.04),
      delay: delay,
      child: Skelton(
        height: 50.h,
        color: Colors.black.withOpacity(0.00),
      ),
    );
  }
}
