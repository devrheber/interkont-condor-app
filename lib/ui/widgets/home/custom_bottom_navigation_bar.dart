import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.colorFondo,
    required this.primerBotonDesactivado,
    required this.segundoBotonDesactivado,
    this.txtPrimerBoton,
    required this.txtSegundoBoton,
    this.accionPrimerBoton,
    this.accionSegundoBoton,
  }) : super(key: key);

  final Color colorFondo;
  final bool primerBotonDesactivado;
  final bool segundoBotonDesactivado;
  final String? txtPrimerBoton;
  final String txtSegundoBoton;
  final dynamic accionPrimerBoton;
  final dynamic accionSegundoBoton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: 16.77.sp,
          left: accionPrimerBoton != null ? 46.19.sp : 28.sp,
          right: accionPrimerBoton != null ? 46.19.sp : 28.sp),
      child: Row(
        children: <Widget>[
          if (accionPrimerBoton != null)
            Expanded(
              child: btnCancelar(context, colorFondo, txtPrimerBoton,
                  accionPrimerBoton, primerBotonDesactivado),
            ),
          if (accionPrimerBoton != null)
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
                        color: const Color(0xff808080),
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
  Color colorBoton = const Color(0xff22B573);
  if (desactivado == true) {
    colorBoton = const Color(0xff808080);
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
            height: 42.3.sp,
            // color: AppTheme.bottomPrincipal,

            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        '$texto',
                        maxLines: 1,
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
