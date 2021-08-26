import 'dart:convert';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/obtenerDatosProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../theme/color_theme.dart';

final titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
 
    return Stack( 
      children: <Widget>[
        
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 107.sp),
          child: Stack(
            children: <Widget>[
              Container(
                width: 358.w,
                height: 126.h,
                margin:
                    EdgeInsets.only(top: 50.0.sp, right: 28.sp, left: 28.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffC1C8D9).withOpacity(.3),
                      blurRadius: 26.sp,
                      offset: Offset(3.sp, 4.sp),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 55.0.sp),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Bienvenido',
                        style: TextStyle(
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(
                        height: 5.0.sp,
                      ),
                      Text(
                        contenidoWebService[0]['usuario']['nombreUsu'],
                        // 'Usuario Admin',
                        style: TextStyle(
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.w200,
                          fontSize: 15.sp,
                          color: Color(0xFF566B8C),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 77.sp,
                          width: 77.sp,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: Colors.white, width: 5.sp),
                          ),
                          child: Image.asset('assets/new/home/profile.png',
                              fit: BoxFit.fill),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 280.sp, left: 20.0, right: 20.0),
            // color: Colors.black,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Mis Proyectos ',
                          style: TextStyle(
                            fontFamily: "mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Color(0xFF000000),
                          ),
                        ),
                        Text(
                          '(${contenidoWebService[0]['proyectos'].length} proyectos)',
                          style: TextStyle(
                            fontFamily: "mulish",
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            color: ColorTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Selecciona un proyecto',
                      style: TextStyle(
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w200,
                        fontSize: 15.sp,
                        color: Color(0xFF566B8C),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (int cont = 0;
                        cont < contenidoWebService[0]['proyectos'].length;
                        cont++)
                      proyecto(
                          context,
                          cont,
                          contenidoWebService[0]['proyectos'][cont]
                              ['codigoproyecto'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['nombrecategoria'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['nombreproyecto'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['valorejecutado'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['valorproyecto'],
                          // false,
                          contenidoWebService[0]['proyectos'][cont]
                              ['porPublicar'],
                          'icn-linea-1',
                          contenidoWebService[0]['proyectos'][cont]
                              ['semaforoproyecto'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['colorcategoria'],
                          contenidoWebService[0]['proyectos'][cont]
                              ['imagencategoria']),
                    if (contenidoWebService[0]['proyectos'].length == 0)
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    height: 150.0,
                                    margin: EdgeInsets.only(
                                        bottom: 20.0, top: 20.0, right: 20.0),
                                    child: Image.asset(
                                        'assets/img/Desglose/Demas/img-noimage.png'),
                                  )),
                                ],
                              ),
                              Text(
                                'Aún no tienes proyectos',
                                style: AppTheme.comentarioPlomo,
                              )
                            ],
                          ))
                  ],
                )),
              ],
            )),
      ],
    );
  }

  Widget proyecto(
      context,
      posicion,
      idProyecto,
      titulo,
      descripcion,
      valorEjecutado,
      valorProyecto,
      faltaPublicar,
      nombreIcono,
      nombreSemaforo,
      colorTitulo,
      imagencategoria) {
    int porcentaje = ((100 * valorEjecutado) / valorProyecto).round();

    String iconoSemaforo = 'semaforo-3';
    if (nombreSemaforo == 'rojo') {
      iconoSemaforo = 'semaforo-3';
    } else if (nombreSemaforo == 'amarillo') {
      iconoSemaforo = 'semaforo-2';
    } else if (nombreSemaforo == 'verde') {
      iconoSemaforo = 'semaforo-1';
    }

    colorTitulo = colorTitulo.split("#");
    colorTitulo = "0XFF" + colorTitulo[1];

    // VALOR EN MILLONES
    var valorProyectoRedondeado = valorProyecto / 1000000;
    valorProyectoRedondeado =
        double.parse((valorProyectoRedondeado).toStringAsFixed(1));

    var imagen;

    if (conexionInternet == true) {
      imagen = Image.network('$imagencategoria');
      // imagen = Image.asset(
      //   'assets/img/Desglose/Demas/question.png',
      // );
    } else {
      imagen = Image.asset(
        'assets/img/Desglose/Demas/question.png',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15.sp)),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.white,
        child: InkWell(
            onTap: () async {
              _seleccionarProyecto(context, posicion, idProyecto, nombreIcono);
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 1.sp, top: 1.sp),
                padding: EdgeInsets.only(
                    top: 24.sp, bottom: 24.sp, left: 28.sp, right: 4.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(flex: 1, child: imagen),
                        Expanded(
                            flex: 4,
                            child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            '$titulo'.toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.sp,
                                                
                                                letterSpacing: 0.4,
                                                
                                                color: Color(
                                                    int.parse(colorTitulo))),
                                            // style: AppTheme.tituloParrafo
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.5,
                                    ),
                                    Text('$descripcion',
                                        style: TextStyle(
                                            fontFamily: "montserrat",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                            color: Color(0xFF000000))),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 90.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                          width: 0.3,
                                                          color:
                                                              Color(0xFF000000),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '\$ $valorProyectoRedondeado' +
                                                          'M',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "montserrat",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15.sp,
                                                        letterSpacing: 0.4,
                                                        height: 0.9,
                                                        color:
                                                            Color(0xFF808080),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                              width: 0.3,
                                                              color: Color(
                                                                  0xFFFF000000)),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '$porcentaje' + '%',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "montserrat",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15.sp,
                                                            letterSpacing: 0.4,
                                                            height: 0.9,
                                                            color: Color(
                                                                0xFF808080),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Center(
                                                          child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Image.asset(
                                                      'assets/img/Desglose/Home/$iconoSemaforo.png',
                                                      height: 19.sp,
                                                      width: 50.95.sp,
                                                    ),
                                                  ))),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Text(''),
                                        // )
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                    if (faltaPublicar != null)
                      if (faltaPublicar == true)
                        Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Image.asset(
                                      'assets/img/Desglose/Home/btn-por-publicar.png'))
                            ],
                          ),
                        )
                  ],
                ))),
      ),
    );
  }

  _seleccionarProyecto(context, posicion, idProyecto, nombreIcono) async {
    posicionListaProyectosSeleccionado = posicion;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (contenidoWebService[0]['proyectos'][posicion]['paso'] == null) {
      contenidoWebService[0]['proyectos'][posicion]['paso'] = 0;
      prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));
    } else {}
    print('PASO ACTUAL:');
    print(contenidoWebService[0]['proyectos'][posicion]['paso']);

    var respuesta = await obtenerDatosProyecto(idProyecto, true);
    if (respuesta) {
      switch (contenidoWebService[0]['proyectos'][posicion]['paso']) {
        case 0:
          cambiarPagina(context, Proyecto());
          break;
        case 1:
          cambiarPagina(context, ReportarAvance());
          break;
        default:
          cambiarPagina(context, ReportarAvance());
      }
    } else {
      print('.---------------.');
      print(contenidoWebService[0]['proyectos'][posicion]['datos']);
      if (contenidoWebService[0]['proyectos'][posicion]['datos'] != null) {
        switch (contenidoWebService[0]['proyectos'][posicion]['paso']) {
          case 0:
            cambiarPagina(context, Proyecto());
            break;
          case 1:
            cambiarPagina(context, ReportarAvance());
            break;
          default:
            cambiarPagina(context, ReportarAvance());
        }
      } else {
        Toast.show(
            "Lo sentimos, este proyecto no fue sincronizado anteriormente",
            context,
            duration: 3,
            gravity: Toast.BOTTOM);
      }
      //miomio
    }
  }
}
