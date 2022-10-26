import 'package:appalimentacion/routes/app_routes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../domain/models/models.dart';
import '../../globales/colores.dart';
import '../../theme/color_theme.dart';
import '../authentication/authentication_provider.dart';
import '../lista_proyectos_page/projects_provider.dart';
import '../report_progress/cuerpo/last_step/noInternet.dart';
import '../widgets/cargando.dart';
import '../widgets/proyecto_card.dart';

final titleColor = Color(0xff444444);

class ProyectosContenidoAOM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //!PROVISIONAL HASTA IMPLEMENTAR EL PROVIDER DE PROYECTOS AOM
    final projectsProvider = Provider.of<ProjectsProvider>(context);

    ToastContext().init(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
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
                        context.read<AuthenticationProvider>().user?.username ??
                            '',
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
          width: double.infinity,
          margin: EdgeInsets.only(top: 280.sp, left: 20.0, right: 20.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              //! CONSUMIR PROYECTOS AOM
              StreamBuilder<List<Project>>(
                  stream: projectsProvider.projectsStream,
                  builder: (context, AsyncSnapshot<List<Project>> snapshot) {
                    if (!snapshot.hasData) {
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
                                  margin: EdgeInsets.only(
                                      bottom: 20.0, top: 20.0, right: 20.0),
                                  child: Image.asset(
                                      'assets/img/Desglose/Demas/img-noimage.png'),
                                )),
                              ],
                            ),
                            const Text(
                              'Aún no tienes proyectos',
                              style: AppTheme.comentarioPlomo,
                            )
                          ],
                        ),
                      );
                    }
                    final projects = snapshot.data!;

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
                                '(${projects.length} proyectos)',
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
                                  loadingDialog(context);

                                  await projectsProvider
                                      .getRemoteProjects()
                                      .then((value) {
                                    Navigator.pop(context);
                                  }).onError(
                                    (Object? error, StackTrace stackTrace) {
                                      Navigator.pop(context);
                                      noInternetConnection(context);
                                      Toast.show(
                                        'Algo salió mal',
                                        duration: 4,
                                      );
                                    },
                                  );
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
                          for (int i = 0; i < projects.length; i++)
                            ProjectCard(
                              project: projects[i],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.aomDetalle,
                                  arguments: projects[i],
                                );
                              },
                              stream: Container(),
                            ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
