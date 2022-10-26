import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CongratsDialog extends StatelessWidget {
  const CongratsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context)
            .pushReplacementNamed(AppRoutes.listaProyectosAOM);

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: ColorTheme.congratsGradient),
            ),
            Image.asset(
              'assets/new/home/congrats.gif',
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100.sp),
                  Image(
                    image: AssetImage('assets/new/home/congrats_check.png'),
                    width: 44.sp,
                    height: 44.sp,
                  ),
                  SizedBox(height: 20.sp),
                  Text(
                    'El reporte de actualización\nAOM fue registrado\n correctamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Image.asset('assets/new/home/success.png', width: 288.sp),

                  SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                      onTap: () async {
                        await Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.listaProyectosAOM);
                      },
                      child: Container(
                        height: 53.sp,
                        margin: EdgeInsets.symmetric(horizontal: 91.sp),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.w),
                            color: Color(0xff49CC85),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Regresar',
                                style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
