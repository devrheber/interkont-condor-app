import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget contenidoBottom(
    {BuildContext context,
    Color colorFondo,
    bool dosBotones,
    bool primerBotonDesactivado,
    bool segundoBotonDesactivado,
    String txtPrimerBoton,
    String txtSegundoBoton,
    dynamic accionPrimerBoton,
    dynamic accionSegundoBoton}) {
  return Container(
    margin: EdgeInsets.only(
        bottom: 16.77.sp,
        left: dosBotones ? 46.19.w : 28.sp,
        right: dosBotones ? 46.19.w : 28.sp),
    child: Row(
      children: <Widget>[
        if (dosBotones)
          Expanded(
            child: btnCancelar(context, colorFondo, txtPrimerBoton,
                accionPrimerBoton, primerBotonDesactivado),
          ),
        if (dosBotones)
          SizedBox(
            width: 11.8.w,
          ),
        Expanded(
          child: btnSiguiente(context, colorFondo, txtSegundoBoton,
              accionSegundoBoton, segundoBotonDesactivado),
        )
      ],
    ),
  );
}

Widget btnCancelar(context, colorFondo, texto, accion, desactivado) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30.sp),
    child: Material(
      color: Colors.white,
      child: InkWell(
          onTap: () {
            accion();
          },
          child: Container(
            width: 154.95.h,
            height: 42.3.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.sp),
              border: Border.all(
                color: Color(0xffc1272d),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '$texto',
                    style: TextStyle(
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.27.sp),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    ),
  );
}

Widget btnSiguiente(context, colorFondo, texto, accion, desactivado) {
  Color colorBoton = Color(0xff22B573);
  if (desactivado == true) {
   colorBoton = Color(0xff808080);
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(30.sp),
    child: Material(
      color: colorBoton,
      child: InkWell(
          onTap: () {
            accion();
          },
          child: Container(
            width: texto != "Siguiente Paso" ? 154.95.w : 361.58.w,
            height:    42.3.h,
            // color: AppTheme.bottomPrincipal,

            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '$texto',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: texto != "Siguiente Paso"
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize:
                            texto != "Siguiente Paso" ? 14.2.sp : 13.27.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
          )),
    ),
  );
}
