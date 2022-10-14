import 'dart:async';
import 'dart:math' as math;
import 'package:appalimentacion/ui/proyecto/project_detail_provider.dart';
import 'package:appalimentacion/utils/assets/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../globales/colores.dart';
import '../../globales/customed_app_bar.dart';

final titleColor = Color(0xff444444);

class CardTitulo extends StatelessWidget {
  const CardTitulo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<ProjectDetailProvider>(context);
    final project = detailProvider.project;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60.h),
          child: Stack(
            children: <Widget>[
              const _Title(),
              _CircleImageCard(
                imgUrl: project.imagencategoria,
              ),
              const _SyncButton(),
            ],
          ),
        ),
        customedAppBar(
          title: '',
          onPressed: () {
            // cambiarPagina(context, ListaProyectos());
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _CircleImageCard extends StatelessWidget {
  const _CircleImageCard({
    Key key,
    @required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

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
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: 77.sp,
                  width: 77.sp,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/img/Desglose/Demas/question.png',
                    height: 77.sp,
                    width: 77.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<ProjectDetailProvider>(context);
    final cache = context.watch<ProjectDetailProvider>().cache;
    final project = detailProvider.project;

    final ultimaSincro = context.watch<ProjectDetailProvider>().ultimaSincro;

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
                project.nombreproyecto,
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
                    visible: cache?.ultimaFechaSincro == null,
                    child: Image.asset(
                      'assets/img/Desglose/Demas/icn-alert.png',
                      height: 14.sp,
                    ),
                  ),
                  Text(
                    cache?.ultimaFechaSincro == null
                        ? ' Nunca'
                        : ultimaSincro == null
                            ? cache.ultimaFechaSincro
                            : ' Justo Ahora',
                    textAlign: TextAlign.center,
                    style: cache?.ultimaFechaSincro == null
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
                  ),
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
                  project.objeto,
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

class _SyncButton extends StatefulWidget {
  const _SyncButton({
    Key key,
  }) : super(key: key);

  @override
  State<_SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<_SyncButton>
    with TickerProviderStateMixin {
  AnimationController animationController;

  int _ultimaSincro;

  int get ultimaSincro => _ultimaSincro;

  set ultimaSincro(int value) {
    _ultimaSincro = value;
    if (value == 1) {
      Timer(const Duration(seconds: 10), () {
        _ultimaSincro = null;
        if (mounted) {
          setState(() {});
        }
      });
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                    onPressed: () async {
                      final detailService =
                          context.read<ProjectDetailProvider>();
                      if (animationController != null &&
                          animationController.isAnimating) return;
                      animationController.repeat();

                      final result = await detailService.syncDetail();

                      animationController.reset();
                      animationController.stop();

                      if (result) {
                        Toast.show(
                            "Proyecto sincronizado correctamente!", context,
                            duration: 3, gravity: Toast.BOTTOM);
                      } else {
                        Toast.show(
                            "Lo sentimos, debe estar conectado a internet para sincronizar el proyecto",
                            context,
                            duration: 3,
                            gravity: Toast.BOTTOM);
                      }
                    },
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
                            animationController != null
                                ? AnimatedBuilder(
                                    animation: animationController,
                                    builder: (_, child) {
                                      print("\x1B[2J\x1B[0;0H");

                                      return Transform.rotate(
                                        angle: animationController.value *
                                            2 *
                                            math.pi,
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
