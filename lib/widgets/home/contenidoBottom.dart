import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget contenidoBottom(
  context,
  Color colorFondo,
  bool dosBotones,
  bool primerBotonDesactivado,
  bool segundoBotonDesactivado,
  String txtPrimerBoton,
  String txtSegundoBoton,
  accionPrimerBoton,
  accionSegundoBoton
  )
{
  return Row(
    children: <Widget>[
      if(dosBotones == true)
      Expanded(
        child: btnCancelar(
          context,
          colorFondo,
          txtPrimerBoton,
          accionPrimerBoton,
          primerBotonDesactivado
        ),
      ),
      Expanded(
        child: btnSiguiente(
          context,
          colorFondo,
          txtSegundoBoton,
          accionSegundoBoton,
          segundoBotonDesactivado
        ),
      )
    ],
  );
}


Widget btnCancelar(
  context,
  colorFondo,
  texto,
  accion,
  desactivado
  )
{
  return GestureDetector(
    onTap: (){
      accion();
    },
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colorFondo,
        border: Border.all(
          color: colorFondo,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only( 
            topLeft:     Radius.circular(50.0),
            topRight:    Radius.circular(50.0),
            bottomLeft:  Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.red),
            left: BorderSide(width: 0.5, color: Colors.red),
            right: BorderSide(width: 0.5, color: Colors.red),
            bottom: BorderSide(width: 0.5, color: Colors.red),
          ),
        ),
        padding: EdgeInsets.only(left:20.0, right: 20.0, top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                '$texto',
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ),
    )
  );
}


Widget btnSiguiente(
  context,
  colorFondo,
  texto,
  accion,
  desactivado
  )
{
  Color colorBoton = AppTheme.verdeClaro;
  if(desactivado == true){
    colorBoton = Colors.grey;
  }

  return GestureDetector(
    onTap: (){
      accion();
    },
    child: Container(
      padding: EdgeInsets.all(10.0),
      // color: AppTheme.bottomPrincipal,
      decoration: BoxDecoration(
        color: colorFondo,
        border: Border.all(
          color: colorFondo,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only( 
            topLeft:     Radius.circular(50.0),
            topRight:    Radius.circular(50.0),
            bottomLeft:  Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              colorBoton,
              colorBoton
            ],
          ),
        ),
        padding: EdgeInsets.only(
          left:20.0, 
          right: 20.0, 
          top: 10.0, 
          bottom: 10.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                '$texto',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.center,
                
              )
            )
          ],
        )
      ),
    )
  );
}
