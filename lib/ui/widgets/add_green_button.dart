import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddGreenButton extends StatelessWidget {
  const AddGreenButton({Key key, @required this.onTap,}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.sp),
      child: Material(
        color: Color(0xff22B573),
        child: InkWell(
            onTap: onTap,
            child: Container(
              child: Container(
                  height: 47.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Añadir',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 14.2.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                    ],
                  )),
            )),
      ),
    );
  }
}
