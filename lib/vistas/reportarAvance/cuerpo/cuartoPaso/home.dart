import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/cajonTexto.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/mostrarFotoPrincipal.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/mostrarFotosSubidas.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class CardCuerpoCuartoPaso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/3.3, 
            left: 20.0, 
            right: 20.0
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5.0, left:5.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Descripción & Documentos',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 17,
                              color: Color(0xFF334660),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          cajonTextoComentarios(
                            context, 
                            'Comentarios', 
                            'Aca puede agregar una descripción del avance..'
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Agregar una foto principal del avance (Obligatorio)',
                            style: AppTheme.parrafo
                          ),
                          MostrarFotoSubida(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Agregar fotos complementarias (Max 5)',
                            style: AppTheme.parrafo
                          ),
                          Text(
                            'Tambien puedes tomar una foto a tus documentos',
                            style: AppTheme.parrafo
                          ),
                          

                          MostrarFotosSubidas()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      ],
    );
  }
}