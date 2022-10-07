import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/documentos_adicionales.dart';
import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/informe_admin_interventor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../globales/title_subtitle.dart';
import '../../../../globales/variables.dart';
import 'cajonTexto.dart';
import 'foto_principal.dart';
import 'fotos_complementarias.dart';

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
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 230.h,
            ),
            child:
                ListView(physics: BouncingScrollPhysics(), children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 31.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextTitle(text: 'Descripción & Documentos'),
                          SizedBox(height: 2.sp),
                          cajonTextoComentarios(
                            context,
                            'Comentarios',
                            'Aca puede agregar una descripción del avance..',
                            (value) {
                              contenidoWebService[0]['proyectos']
                                      [posListaProySelec]
                                  ['datos']['txtComentario'] = value;
                              if (value.length > 1) {
                                boolestSegundoBtnreportarAvance = false;
                              } else {
                                boolestSegundoBtnreportarAvance = true;
                              }
                            },
                          ),
                          SizedBox(height: 22.8.sp),
                          TextSubtitle2(
                            text: 'Agregar una foto principal del avance',
                            isRequired: true,
                          ),
                          SizedBox(height: 23.15.sp),
                          FotoPrincipal(),
                          SizedBox(height: 22.8.sp),
                          TextSubtitle2(
                            text:
                                'Agregar el informe de Administrador/Interventor',
                            isRequired: true,
                          ),
                          SizedBox(height: 22.8.sp),
                          InformeAdminInterventor(),
                          SizedBox(height: 22.8.sp),
                          TextSubtitle2(
                            text: 'Agregar Documentos adicionales',
                          ),
                          SizedBox(height: 22.8.sp),
                          DocumentosAdicionales(),
                          SizedBox(height: 22.8.sp),
                          TextSubtitle2(
                            text:
                                'Agregar fotos complementarias (Max 5)\nTambien puedes tomar una foto a tus documentos',
                          ),
                          SizedBox(height: 23.15.sp),
                          FotosComplementarias()
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
