
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShinyAnimation extends StatefulWidget {
  const ShinyAnimation({
    Key? key,
    required this.child,
    this.color = Colors.blue,
    this.delay = Duration.zero,
  }) : super(key: key);

  final Widget child;
  final Duration delay;
  final Color color;

  @override
  State<ShinyAnimation> createState() => _ShinyAnimationState();
}

class _ShinyAnimationState extends State<ShinyAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.forward(from: 0.0);
      }
    });
    Future.delayed(widget.delay, () {
      if (!mounted) return;
      _controller?.forward();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller ?? AnimationController(vsync: this),
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color,
                  Colors.white.withOpacity(0.2),
                  widget.color,
                ],
                stops: [
                  0.0,
                  _controller?.value ?? 0,
                  1.0
                ]),
          ),
          child: widget.child,
        );
      },
    );
  }
}
