import 'package:appalimentacion/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QualitativeProgressCard extends StatelessWidget {
  const QualitativeProgressCard({
    Key key,
    @required this.item,
    @required this.deleteMethod,
  }) : super(key: key);

  final QualitativeProgress item;
  final VoidCallback deleteMethod;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontFamily: 'montserrat',
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xff556a8d),
    );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(
        left: 18.26.sp,
        right: 14.76.sp,
        top: 18.48.sp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  '${item.aspectToEvaluateId}',
                  style: TextStyle(
                    color: Color(0xff334660),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.61.sp,
                    fontFamily: 'montserrat',
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: deleteMethod,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Eliminar',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xffC1272D),
                            fontWeight: FontWeight.w300,
                            fontSize: 10.32.sp,
                            fontFamily: 'montserrat',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          width: 23.53.sp,
                          child: Image.asset(
                            'assets/img/Desglose/Demas/btn-delete.png',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.35.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'LOGROS',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${item.achive}',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '\nDIFICULTADES',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${item.difficulty}',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
