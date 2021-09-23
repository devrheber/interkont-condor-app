import 'package:appalimentacion/globales/add_button_green.dart';
import 'package:appalimentacion/globales/title_subtitle.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/bloqueAgregado.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/cajonTexto.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/segundoPaso/seleccionarAvance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

class CardCuerpoSegundoPaso extends StatefulWidget {
  CardCuerpoSegundoPaso({Key key}) : super(key: key);

  @override
  CardCuerpoSegundoPasoState createState() => CardCuerpoSegundoPasoState();
}

class CardCuerpoSegundoPasoState extends State<CardCuerpoSegundoPaso> {
  List listaLogrosDificultades = [];
  String txtLogro = '';
  String txtDificultad = '';
  bool reiniciarLogroDificultad = false;

  TextEditingController controllerLogro = TextEditingController();
  TextEditingController controllerDificultad = TextEditingController();

  @override
  void initState() {
    if (contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['avancesCualitativos'] !=
        null) {
      setState(() {
        listaLogrosDificultades = contenidoWebService[0]['proyectos']
                [posicionListaProyectosSeleccionado]['datos']
            ['avancesCualitativos'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          // color: Colors.black,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 31.sp),
                padding: EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTextTitle(text: 'Avance Cualitativo'),
                    SizedBox(height: 2.sp),
                    buildTextSubtitle(
                        text: '¿Qué logros y dificultades se presentaron?'),
                    SizedBox(height: 18.sp),
                    SeleccionarAvance(),
                    cajonTexto(
                        'Ingrese los logros',
                        'Acá puede agregar los logros que obtuvo el proyecto...',
                        true, (texto) {
                      setState(
                        () {
                          txtLogro = texto;
                        },
                      );
                    }, controllerLogro),
                    cajonTexto(
                        'Ingrese las dificultades',
                        'Acá puede agregar los dificultades que obtuvo el proyecto...',
                        false, (texto) {
                      setState(
                        () {
                          txtDificultad = texto;
                        },
                      );
                    }, controllerDificultad),
                    SizedBox(height: 8.sp),
                    buildAddGreenButton(
                      onTap: () => anadirLogroDificultad(),
                    ),
                    for (int cont = 0;
                        cont < listaLogrosDificultades.length;
                        cont++)
                      bloqueAgregado(
                          context,
                          listaLogrosDificultades[cont]['titulo'],
                          listaLogrosDificultades[cont]['logro'],
                          listaLogrosDificultades[cont]['dificultad'], () {
                        listaLogrosDificultades.removeAt(cont);
                        setState(() {
                          listaLogrosDificultades = listaLogrosDificultades;
                        });
                        contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]['datos']
                            ['avancesCualitativos'] = listaLogrosDificultades;
                      })
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void anadirLogroDificultad() {
    if (txtLogro != '' || txtDificultad != '') {
      controllerLogro.clear();
      controllerDificultad.clear();
      listaLogrosDificultades.add({
        'aspectoEvaluarId': idAspectoEvaluar,
        'titulo': txtBtnDesplegableAvanceCualitativo,
        'logro': txtLogro,
        'dificultad': txtDificultad,
      });
      setState(() {
        listaLogrosDificultades = listaLogrosDificultades;
        txtLogro = '';
        txtDificultad = '';
      });

      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
          ['datos']['avancesCualitativos'] = listaLogrosDificultades;
    }
  }
}
