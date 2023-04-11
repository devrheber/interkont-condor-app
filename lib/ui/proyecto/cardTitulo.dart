import 'dart:math' as math;

import 'package:appalimentacion/blocs/network/network_bloc.dart';
import 'package:appalimentacion/ui/proyecto/bloc/project_detail_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../globales/colores.dart';
import '../../globales/customed_app_bar.dart';
import '../../utils/assets/assets.dart';

const titleColor = Color(0xff444444);

class CardTitulo extends StatelessWidget {
  const CardTitulo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
      return Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 60),
            child: Stack(
              children: <Widget>[
                const _Title(),
                _CircleImageCard(
                  imgUrl: state.project.imagencategoria,
                ),
                _SyncButton(
                  isLoading: state.isLoading,
                ),
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
    });
  }
}

class _CircleImageCard extends StatelessWidget {
  const _CircleImageCard({
    Key? key,
    required this.imgUrl,
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
                height: 77,
                width: 77,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    height: 77,
                    width: 77,
                    fit: BoxFit.fitWidth,
                    placeholder: (_, __) => Image.asset(
                      'assets/img/Desglose/Demas/question.png',
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img/Desglose/Demas/question.png',
                      height: 77,
                      width: 77,
                    ),
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

class _Title extends StatefulWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  State<_Title> createState() => TitleState();
}

class TitleState extends State<_Title> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
      final project = state.project;
      return Container(
        width: double.infinity,
        height: 204,
        padding: const EdgeInsets.only(top: 1.0, bottom: 10.0),
        margin: const EdgeInsets.only(top: 40, right: 28, left: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(const Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffC1C8D9).withOpacity(.3),
              blurRadius: 26,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 42, right: 42),
                child: Text(
                  project.nombreproyecto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff556A8D),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Últ. sincronización ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff566B8C),
                      ),
                    ),
                    Visibility(
                      visible: state.cache.lastSyncDate == null,
                      child: Image.asset(
                        'assets/img/Desglose/Demas/icn-alert.png',
                        height: 14,
                      ),
                    ),
                    Text(
                      state.cache.getLastDateSyncFormatted,
                      textAlign: TextAlign.center,
                      style: state.cache.lastSyncDate == null
                          ? const TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xffC1272D),
                            )
                          : state.cache.synchronizationRequired
                              ? AppTheme.parrafoCelesteNegrita
                              : const TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color(0xff22B573),
                                ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.only(left: 19, right: 19),
                child: Center(
                  child: Text(
                    project.objeto,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff505050),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SyncButton extends StatefulWidget {
  const _SyncButton({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  State<_SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<_SyncButton>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    if (widget.isLoading) {
      animationController?.forward();
    }
    ToastContext().init(context);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _SyncButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading) {
      if (widget.isLoading) {
        animationController?.repeat();
      } else {
        animationController?.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkSuccess) {
          if (animationController?.isAnimating ?? false) {
            return;
          }
          context.read<ProjectDetailBloc>().add(SyncDetail());
        }
      },
      child: Positioned(
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 226),
          width: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 143,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final isConnected = verifyConnection();
                      if (!isConnected) {
                        Toast.show(
                          'Lo sentimos, debe estar conectado a internet para sincronizar el proyecto',
                          duration: 5,
                          gravity: Toast.bottom,
                        );
                        return;
                      }
                      context.read<ProjectDetailBloc>().add(SyncDetail());
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF33ACE0), width: 5),
                        color: const Color(0xFF33ACE0),
                      ),
                      child: SizedBox(
                        height: 35,
                        width: 143,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            animationController != null
                                ? AnimatedBuilder(
                                    animation: animationController!,
                                    builder: (_, child) {
                                      // print("\x1B[2J\x1B[0;0H");

                                      return Transform.rotate(
                                        angle:
                                            (animationController?.value ?? 0) *
                                                2 *
                                                math.pi,
                                        child: child,
                                      );
                                    },
                                    child: const SyncImage(),
                                  )
                                : const SyncImage(),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.7),
                              child: Text(
                                (animationController?.isAnimating ?? false)
                                    ? 'Sincronizando'
                                    : 'Sincronizar',
                                style: const TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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

  bool verifyConnection() {
    final state = context.read<NetworkBloc>().state;

    if (state is NetworkFailure) {
      return false;
    }

    return true;
  }
}

class SyncImage extends StatelessWidget {
  const SyncImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.assetsNewHomeSync,
      width: 19.2,
      height: 19.2,
    );
  }
}
