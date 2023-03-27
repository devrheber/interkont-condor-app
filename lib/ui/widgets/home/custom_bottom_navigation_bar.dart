import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {Key? key,
      required this.colorFondo,
      required this.primerBotonDesactivado,
      required this.segundoBotonDesactivado,
      this.txtPrimerBoton,
      required this.txtSegundoBoton,
      this.accionPrimerBoton,
      this.accionSegundoBoton,
      this.heightSecondButton})
      : super(key: key);

  final Color colorFondo;
  final bool primerBotonDesactivado;
  final bool segundoBotonDesactivado;
  final String? txtPrimerBoton;
  final String txtSegundoBoton;
  final dynamic accionPrimerBoton;
  final dynamic accionSegundoBoton;
  final double? heightSecondButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          bottom: 16.77,
          left: accionPrimerBoton != null ? 46.19 : 28,
          right: accionPrimerBoton != null ? 46.19 : 28),
      child: Row(
        children: <Widget>[
          if (accionPrimerBoton != null)
            Expanded(
              child: btnCancelar(context, colorFondo, txtPrimerBoton,
                  accionPrimerBoton, primerBotonDesactivado),
            ),
          if (accionPrimerBoton != null)
            const SizedBox(
              width: 11.8,
            ),
          Expanded(
            child: btnSiguiente(context, colorFondo, txtSegundoBoton,
                accionSegundoBoton, segundoBotonDesactivado,
                height: heightSecondButton),
          )
        ],
      ),
    );
  }
}

Widget btnCancelar(context, colorFondo, texto, accion, desactivado) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Material(
      color: Colors.white,
      child: InkWell(
          onTap: () {
            accion();
          },
          child: Container(
            width: 154.95,
            height: 42.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xffc1272d),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '$texto',
                    style: const TextStyle(
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.27),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    ),
  );
}

Widget btnSiguiente(context, colorFondo, texto, accion, desactivado,
    {double? height}) {
  Color colorBoton = const Color(0xff22B573);
  if (desactivado == true) {
    colorBoton = const Color(0xff808080);
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Material(
      color: colorBoton,
      child: InkWell(
          onTap: () {
            accion();
          },
          child: SizedBox(
            width: texto != "Siguiente Paso" ? 154.95 : 361.58,
            height: height ?? 42.3,
            // color: AppTheme.bottomPrincipal,

            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 1),
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
                            fontSize: texto != "Siguiente Paso" ? 14.2 : 13.27),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
          )),
    ),
  );
}
