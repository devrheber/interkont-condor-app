import 'package:appalimentacion/ui/report_progress/last_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'felicitaciones.dart';
import 'noInternet.dart';

class LastStep extends StatefulWidget {
  const LastStep._();

  static Widget init() {
    return ChangeNotifierProvider(
      create: (context) => LastStepProvider(),
      child: const LastStep._(),
    );
  }

  @override
  State<StatefulWidget> createState() => _LastStepState();
}

class _LastStepState extends State<LastStep>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  String i = '0';
  String contadorRgb = '0';
  bool correcto = false;
  bool pasaron10Segundos = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation objects value
          i = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();

    super.initState();
    // TODO
    // Future.delayed(
    //   Duration(seconds: 10),
    //   () {
    //     setState(() {
    //       pasaron10Segundos = true;
    //     });
    //     if (correcto == true) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => Felicitaciones()),
    //       );
    //     } else {
    //       Toast.show("Espere un momento en linea porfavor", context,
    //           duration: 5, gravity: Toast.BOTTOM);
    //     }
    //   },
    // );
  }

  Future<void> sendData() async {
    final result = await context.read<LastStepProvider>().guardarAlimentacion();

    if (result['success'] as bool) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Felicitaciones()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoInternet()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Widget> getRootPage() async => Felicitaciones();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  percent: double.parse('$i') / 100,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$i",
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "%",
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  progressColor: Color(0xff90CBF9),
                  animateFromLastPercent: true,
                )),
                SizedBox(height: 23.sp),
                Text(
                  "Estamos cargando tu proyecto",
                  style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            /*Positioned(
                width: MediaQuery.of(context).size.width/2,
                height: 100.0,
                top: MediaQuery.of(context).size.height-150.0,
                // top: 20.0,
                right: MediaQuery.of(context).size.width/4.1,
                child: Container(
                  child: Image(
                    image: AssetImage(
                      'assets/img/Desglose/Login/logo-footer.png',
                    )
                  )
                )
              )*/
          ],
        ),
      ),
    );
  }

  Widget aro(Widget contenido, int rgb) {
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
