import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../globales/variables.dart';

final titleColor = Color(0xff444444);
Widget cajonTextoComentarios(context, textoTitulo, textoHint, accion) {
  TextEditingController controllerCuartoPasoTxtComentarios =
      TextEditingController();
  if (contenidoWebService[0]['proyectos'][posListaProySelec]
          ['datos']['txtComentario'] !=
      null) {
    controllerCuartoPasoTxtComentarios.text = contenidoWebService[0]
            ['proyectos'][posListaProySelec]['datos']
        ['txtComentario'];
  }
  return Container(
      width: double.infinity,
      height: 106.2.h,
      margin: EdgeInsets.only(top: 35.sp),
      padding: EdgeInsets.only(left: 15.0.sp, right: 15.sp, top: 13.27.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(

                child: Image.asset('assets/new/home/comments.png',
                    width: 18.85.w, height: 18.85.w),
              ),
              SizedBox(width: 11.8.sp),
              Expanded(
                child: Text(
                  '$textoTitulo',
                  style: TextStyle(
                    color: Color(0xff556A8D),
                    fontSize: 15.27.sp,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: TextField(
                textInputAction: TextInputAction.send, 
                controller: controllerCuartoPasoTxtComentarios,
                onChanged: accion,
                maxLines: 4,
                 style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Color(0xff556A8D),
              ),
                decoration: InputDecoration.collapsed(
                  hintText: "$textoHint",
                  hintStyle: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Color(0xff556A8D).withOpacity(0.8),
                  ),
                ),
              ),
            ),
          )
        ],
      ));
}
