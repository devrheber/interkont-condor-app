import 'dart:async';

import 'package:appalimentacion/ui/aom_last_step_page/congrats_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LastStepAOM extends StatefulWidget {
  const LastStepAOM({
    Key? key,
  }) : super(key: key);

  @override
  State<LastStepAOM> createState() => _LastStepAOMState();
}

class _LastStepAOMState extends State<LastStepAOM> {
  double counter = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      counter += 0.05;
      if (counter >= 1) {
        timer.cancel();
        Future.delayed(Duration(milliseconds: 1500), () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: CongratsDialog(),
              insetPadding: EdgeInsets.zero,
              elevation: 0,
            ),
          );
        });
      }

      setState(() {});
    });
  }

  //dispose timer
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 30.sp,
      color: Colors.white,
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Color(0xff2196F3),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularPercentIndicator(
                      radius: 120.sp,
                      lineWidth: 6.sp,
                      percent: counter.clamp(0, 1),
                      center: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${(counter.clamp(0, 1) * 100).round()}",
                            style: style,
                          ),
                          Text(
                            "%",
                            style: style,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      progressColor: Color(0xff90CBF9),
                      animateFromLastPercent: true,
                    ),
                  ),
                  SizedBox(height: 23.sp),
                  Text(
                    counter >= 1
                        ? 'Obteniendo respuesta'
                        : 'Estamos registrando la actualización AOM',
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AroContainer extends StatelessWidget {
  const AroContainer({
    Key? key,
    required this.contenido,
    required this.rgb,
  }) : super(key: key);

  final Widget contenido;
  final int rgb;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(rgb, rgb, rgb, 0.1),
        border: Border(
          top: BorderSide(width: 40.0, color: Colors.transparent),
          left: BorderSide(width: 40.0, color: Colors.transparent),
          right: BorderSide(width: 40.0, color: Colors.transparent),
          bottom: BorderSide(width: 40.0, color: Colors.transparent),
        ),
      ),
      child: contenido,
    );
  }
}
