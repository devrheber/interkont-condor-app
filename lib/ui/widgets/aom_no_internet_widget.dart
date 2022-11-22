import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AomNoInternetWidget extends StatelessWidget {
  const AomNoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
      backgroundColor: Color(0xff002F5E),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/Desglose/Demas/bg-nosenal.jpg"),
                fit: BoxFit.cover),
          ),
          padding:
              EdgeInsets.only(top: 80.0, bottom: 20.0, left: 70.0, right: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/Desglose/Demas/icn-nosenal.png'),
                width: 80.0,
                height: 130,
              ),
              Text(
                'Verifica tu conexion a Internet e intenta ingresar nuevamente',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 21.sp,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 231.sp,
                  height: 53.sp,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff49CC85),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Regresar',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
