import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../globales/colores.dart';

class ModalMensaje{
  static void mensaje(
    BuildContext context, 
    String texto
    )
  {
    modalMostrarMensaje(context, texto);
  }
  static Future<bool?> modalMostrarMensaje(context, String texto) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 225.0,
                padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(
                          FontAwesomeIcons.triangleExclamation, 
                          size: 50.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('$texto', 
                          style: AppTheme.parrafo,
                          textAlign: TextAlign.center,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                textColor: Colors.black,
                                color: Colors.black,
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Aceptar', 
                                  style: AppTheme.parrafo
                                ),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            
                          ],
                        ),
                      )
                    ], 
                  ),
                ),
            );
        }
    );
  }

  static void mensajeOpcion(
    BuildContext context, 
    String texto,
    Function opcion,
    Color colorOpcion,
    )
  {
    modalOpcion(context, texto, opcion, colorOpcion);
  }

  static Future<bool?> modalOpcion(context, String texto, Function opcion, Color colorOpcion) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 225.0,
                padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(
                          FontAwesomeIcons.triangleExclamation, 
                          size: 50.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('$texto', 
                          style: AppTheme.h2,
                          textAlign: TextAlign.center,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: colorOpcion,
                                padding: EdgeInsets.all(10.0),
                                child: Text('Salir', style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    )), 
                                onPressed: (){
                                  opcion();
                                },
                              ),
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            );
        }
    );
  }
}
