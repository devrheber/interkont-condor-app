import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

Widget contenidoBottom(
  context,
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
          txtPrimerBoton,
          accionPrimerBoton,
          primerBotonDesactivado
        ),
      ),
      Expanded(
        child: btnSiguiente(
          context,
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
      padding: EdgeInsets.all(20.0),
      color: AppTheme.bottomPrincipal,
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
            top: BorderSide(width: 1.0, color: Colors.red),
            left: BorderSide(width: 1.0, color: Colors.red),
            right: BorderSide(width: 1.0, color: Colors.red),
            bottom: BorderSide(width: 1.0, color: Colors.red),
          ),
        ),
        padding: EdgeInsets.only(left:20.0, right: 20.0, top: 15.0, bottom: 15.0),
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
      padding: EdgeInsets.all(20.0),
      color: AppTheme.bottomPrincipal,
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
        padding: EdgeInsets.only(left:20.0, right: 20.0, top: 15.0, bottom: 15.0),
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
