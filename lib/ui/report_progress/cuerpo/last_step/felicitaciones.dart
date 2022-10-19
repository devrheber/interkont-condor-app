import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../theme/color_theme.dart';
import '../../../listaProyectos/home.dart';

class Felicitaciones extends StatefulWidget {
  Felicitaciones({Key? key}) : super(key: key);

  @override
  _FelicitacionesState createState() => _FelicitacionesState();
}

class _FelicitacionesState extends State<Felicitaciones> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsProvider>().getRemoteProjects();
    context.read<ProjectsProvider>().clearCache();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                SizedBox(height: 100.h),
                Image(
                  image: AssetImage('assets/new/home/congrats_check.png'),
                  width: 44.sp,
                  height: 44.sp,
                ),
                // Text(
                //   '¡Felicitaciones!',
                //   style: TextStyle(
                //     fontFamily: 'montserrat',
                //     fontWeight: FontWeight.bold,
                //     fontSize: 25,
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset('assets/new/home/success.png', width: 288.sp),

                SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaProyectos()),
                      );
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
                              'Volver al inicio',
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
    );
  }
}
