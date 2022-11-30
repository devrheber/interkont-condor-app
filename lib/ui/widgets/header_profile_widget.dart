import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 107.sp),
      child: Stack(
        children: <Widget>[
          Container(
            width: 358.sp,
            height: 126.sp,
            margin: EdgeInsets.only(top: 50.0.sp, right: 28.sp, left: 28.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.sp)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffC1C8D9).withOpacity(.3),
                  blurRadius: 26.sp,
                  offset: Offset(3.sp, 4.sp),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: 55.0.sp),
              child: Column(
                children: <Widget>[
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    height: 5.0.sp,
                  ),
                  Text(
                    context.read<AuthenticationProvider>().user?.username ?? '',
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w200,
                      fontSize: 15.sp,
                      color: const Color(0xFF566B8C),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 77.sp,
                      width: 77.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5.sp),
                      ),
                      child: Image.asset('assets/new/home/profile.png',
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
