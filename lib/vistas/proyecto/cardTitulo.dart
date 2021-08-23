import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/custemed_app_bar.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff444444);

class CardTitulo extends StatefulWidget {
  final int ultimaSincro;
  final activarUltimaSincronizacion;
  CardTitulo({Key key, this.ultimaSincro, this.activarUltimaSincronizacion})
      : super(key: key);

  @override
  CardTituloState createState() => CardTituloState();
}

class CardTituloState extends State<CardTitulo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 60.h),
          child: Stack(
            children: <Widget>[
              buildCardTitulo(),
              buildCircleImageCard(),
              buildSyncButton()
            ],
          ),
        ),
        customedAppBar(
          title: '',
          onPressed: () {
            cambiarPagina(context, ListaProyectos());
          },
        ),
      ],
    );
  }

  Widget buildSyncButton() {
    return Positioned(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 226.sp),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35.sp,
                  width: 143.sp,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: widget.activarUltimaSincronizacion,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF735EF0), width: 5),
                        color: Color(0XFF735EF0),
                      ),
                      child: Container(
                        height: 35.sp,
                        width: 143.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/new/home/sync.png",
                              width: 19.2.sp,
                              height: 19.2.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 7.7.sp),
                              child: Text(
                                'Sincronizar',
                                style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildCircleImageCard() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 77.sp,
                width: 77.sp,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: conexionInternet == true
                            ? NetworkImage(
                                '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['imagencategoria']}',
                              )
                            : AssetImage(
                                'assets/img/Desglose/Demas/question.png',
                              ),
                        fit: BoxFit.fitWidth),
                    border: Border.all(color: Colors.white, width: 5)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCardTitulo() {
    return Container(
        width: double.infinity,
        height: 204.h,
        padding: EdgeInsets.only(top: 1.0, bottom: 10.0),
        margin: EdgeInsets.only(top: 40.h, right: 28.sp, left: 28.sp),
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
            padding: EdgeInsets.only(top: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 42.sp, right: 42.sp),
                  child: Text(
                    '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['nombreproyecto']}'
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Color(0xff556A8D),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                if (contenidoWebService[0]['proyectos']
                            [posicionListaProyectosSeleccionado]
                        ['ultimaFechaSincro'] ==
                    null)
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Últ. sincronización ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: Color(0xff566B8C),
                            ),
                          ),
                          Image.asset(
                            'assets/img/Desglose/Demas/icn-alert.png',
                            height: 14.sp,
                          ),
                          Text(
                            ' Nunca',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Color(0xffC1272D),
                            ),
                          ),
                        ],
                      )),
                if (contenidoWebService[0]['proyectos']
                                [posicionListaProyectosSeleccionado]
                            ['ultimaFechaSincro'] !=
                        null &&
                    widget.ultimaSincro == null)
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Últ. sincronización ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: Color(0xff566B8C),
                            ),
                          ),
                          Text(
                              '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['ultimaFechaSincro']}',
                              textAlign: TextAlign.center,
                              style: AppTheme.parrafoCelesteNegrita),
                        ],
                      )),
                if (widget.ultimaSincro != null)
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Últ. sincronización ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: Color(0xff566B8C),
                            ),
                          ),
                          Image.asset(
                            'assets/new/home/check.png',
                            height: 14.sp,
                          ),
                          Text(
                            ' Justo Ahora',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Color(0xff22B573),
                            ),
                          ),
                        ],
                      )),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 19.sp, right: 19.sp),
                  child: Center(
                    child: Text(
                      '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['objeto']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Color(0xff505050),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
