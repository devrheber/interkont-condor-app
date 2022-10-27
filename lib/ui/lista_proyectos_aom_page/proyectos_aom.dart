import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:appalimentacion/ui/lista_proyectos_aom_page/bloc/aom_projects_bloc.dart';
import 'package:appalimentacion/ui/widgets/cargando.dart';
import 'package:appalimentacion/ui/widgets/proyecto_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

final titleColor = Color(0xff444444);

class ProyectsoContenidoAOMState extends StatelessWidget {
  const ProyectsoContenidoAOMState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AomProjectsBloc>(
      create: (context) => AomProjectsBloc(
        projectsRepository: context.read(),
      )..add(AomProjectsGetProjects()),
      child: const ProyectosContenidoAOM(),
      // TODO Manejar otros problemas de red
    );
  }
}

class ProyectosContenidoAOM extends StatelessWidget {
  const ProyectosContenidoAOM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocListener<AomProjectsBloc, AomProjectsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AomProjectsStatus.failure) {
          LoadingDialog.hide(context);
          Toast.show('Algo salió mal', duration: 4);
        }
        if (state.status == AomProjectsStatus.loading) {
          LoadingDialog.show(context);
        }
        if (state.status == AomProjectsStatus.success) {
          LoadingDialog.hide(context);
        }
      },
      child: Stack(
        children: <Widget>[
          const _ProfileWidget(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 280.sp, left: 20.0, right: 20.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                BlocBuilder<AomProjectsBloc, AomProjectsState>(
                  builder: (context, state) {
                    if (state.projects.isEmpty) {
                      return const _NoProjects();
                      // TODO Escuchar conectividad y volver a intentar obtener proyectos
                    }

                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Proyectos AOM ',
                                style: TextStyle(
                                  fontFamily: "mulish",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              Text(
                                '(${state.projects.length} proyectos)',
                                style: TextStyle(
                                  fontFamily: "mulish",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: ColorTheme.primary,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  context
                                      .read<AomProjectsBloc>()
                                      .add(AomProjectsGetProjects());
                                },
                                child: Icon(Icons.replay_outlined),
                              )
                            ],
                          ),
                          SizedBox(height: 6.sp),
                          AutoSizeText(
                            'Selecciona un proyecto para gestionar el inventario',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 15.sp,
                              color: Color(0xFF566B8C),
                            ),
                          ),
                          SizedBox(height: 20.sp),
                          for (final project in state.projects)
                            ProjectCard(
                              project: project,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.aomDetalle,
                                  arguments: project,
                                );
                              },
                              stream: Container(),
                            ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoProjects extends StatelessWidget {
  const _NoProjects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                margin: EdgeInsets.only(bottom: 20.0, top: 20.0, right: 20.0),
                child: Image.asset('assets/img/Desglose/Demas/img-noimage.png'),
              )),
            ],
          ),
          const Text(
            'Aún no tienes proyectos',
            style: AppTheme.comentarioPlomo,
          ),
        ],
      ),
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  const _ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 107.sp),
      child: Stack(
        children: <Widget>[
          Container(
            width: 358.w,
            height: 126.h,
            margin: EdgeInsets.only(top: 50.0.sp, right: 28.sp, left: 28.sp),
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
                    context.read<AuthenticationProvider>().user?.username ?? '',
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
                        border: Border.all(color: Colors.white, width: 5.sp),
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
    );
  }
}
