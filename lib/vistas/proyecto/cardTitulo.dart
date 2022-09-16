import 'dart:math' as math;

import 'package:appalimentacion/utils/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../globales/colores.dart';
import '../../globales/customed_app_bar.dart';
import '../../globales/transicion.dart';
import '../../globales/variables.dart';
import '../listaProyectos/home.dart';

final titleColor = Color(0xff444444);

class CardTitulo extends StatelessWidget {
  const CardTitulo(
      {Key key,
      this.ultimaSincro,
      this.activarUltimaSincronizacion,
      this.animationController})
      : super(key: key);
  final int ultimaSincro;
  final void Function() activarUltimaSincronizacion;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60.h),
          child: Stack(
            children: <Widget>[
              _Title(ultimaSincro: ultimaSincro),
              _CircleImageCard(),
              _SyncButton(
                activarUltimaSincronizacion: activarUltimaSincronizacion,
                controller: animationController,
              ),
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
}

class _CircleImageCard extends StatelessWidget {
  const _CircleImageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
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
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    @required this.ultimaSincro,
  }) : super(key: key);

  final int ultimaSincro;

  @override
  Widget build(BuildContext context) {
    var fechaUltimaSinc = contenidoWebService[0]['proyectos']
        [posicionListaProyectosSeleccionado]['ultimaFechaSincro'];
    print(fechaUltimaSinc);
    var text = Text(
      fechaUltimaSinc == null
          ? ' Nunca'
          : ultimaSincro == null
              ? fechaUltimaSinc
              : ' Justo Ahora',
      textAlign: TextAlign.center,
      style: fechaUltimaSinc == null
          ? TextStyle(
              fontFamily: "montserrat",
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: Color(0xffC1272D),
            )
          : ultimaSincro == null
              ? AppTheme.parrafoCelesteNegrita
              : TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Color(0xff22B573),
                ),
    );
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
                  Visibility(
                    visible: fechaUltimaSinc == null,
                    child: Image.asset(
                      'assets/img/Desglose/Demas/icn-alert.png',
                      height: 14.sp,
                    ),
                  ),
                  text,
                ],
              ),
            ),
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
        ),
      ),
    );
  }
}

class _SyncButton extends StatelessWidget {
  const _SyncButton({
    Key key,
    @required this.activarUltimaSincronizacion,
    this.controller,
  }) : super(key: key);

  final void Function() activarUltimaSincronizacion;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 226.sp),
        width: double.infinity,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    // elevation: 0,
                    // onPressed: widget.activarUltimaSincronizacion,
                    onPressed: activarUltimaSincronizacion,
                    // padding: EdgeInsets.all(0.0),
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
                            controller != null
                                ? AnimatedBuilder(
                                    animation: controller,
                                    builder: (_, child) {
                                      print("\x1B[2J\x1B[0;0H");
                                      print(controller.value);

                                      return Transform.rotate(
                                        angle: controller.value * 2 * math.pi,
                                        child: child,
                                      );
                                    },
                                    child: SyncImage(),
                                  )
                                : SyncImage(),
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
}

class SyncImage extends StatelessWidget {
  const SyncImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.assetsNewHomeSync,
      width: 19.2.sp,
      height: 19.2.sp,
    );
  }
}
