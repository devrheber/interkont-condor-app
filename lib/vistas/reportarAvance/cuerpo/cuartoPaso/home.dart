import 'package:appalimentacion/globales/title_subtitle.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/cajonTexto.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/mostrarFotoPrincipal.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/mostrarFotosSubidas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

class CardCuerpoCuartoPaso extends StatefulWidget {
  CardCuerpoCuartoPaso({Key key}) : super(key: key);

  @override
  CardCuerpoCuartoPasoState createState() => CardCuerpoCuartoPasoState();
}

class CardCuerpoCuartoPasoState extends State<CardCuerpoCuartoPaso> {
// class CardCuerpoCuartoPaso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: 230.h,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 31.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildTextTitle(text: 'Descripción & Documentos'),
                          SizedBox(height: 2.sp),
                          cajonTextoComentarios(
                            context,
                            'Comentarios',
                            'Aca puede agregar una descripción del avance..',
                            (value) {
                              contenidoWebService[0]['proyectos']
                                      [posicionListaProyectosSeleccionado]
                                  ['datos']['txtComentario'] = value;
                              if (value.length > 1) {
                                boolestSegundoBtnreportarAvance = false;
                              } else {
                                boolestSegundoBtnreportarAvance = true;
                              }
                            },
                          ),
                          SizedBox(height: 22.8.sp),
                          buildTextSubtitle2(
                            text:
                                'Agregar una foto principal del avance (Obligatorio)',
                          ),
                          SizedBox(height: 23.15.sp),
                          MostrarFotoSubida(),
                            SizedBox(height: 22.8.sp),
                            buildTextSubtitle2(
                            text:
                                'Agregar fotos complementarias (Max 5)',
                          ),
                            buildTextSubtitle2(
                            text:
                                'Tambien puedes tomar una foto a tus documentos',
                          ),
                            SizedBox(height: 23.15.sp),
                                
                          MostrarFotosSubidas()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]))
      ],
    );
  }
}
