import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../domain/models/models.dart';
import '../../globales/colores.dart';
import '../../theme/color_theme.dart';
import '../authentication/authentication_provider.dart';
import '../proyecto/project_screen.dart';
import '../report_progress/cuerpo/last_step/noInternet.dart';
import '../widgets/cargando.dart';
import '../widgets/proyecto_card.dart';
import 'projects_provider.dart';

final titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

                    final provider = context.read<ProjectsProvider>();
                    return Container(
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
                                '(${projects.length} proyectos)',
                                style: TextStyle(
                                  fontFamily: "mulish",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: ColorTheme.primary,
                                ),
                              ),
                              const Expanded(child: SizedBox.shrink()),
                              InkWell(
                                onTap: () async {
                                  loadingDialog(context);
                                  await projectsProvider
                                      .getRemoteProjects()
                                      .then((value) => Navigator.pop(context))
                                      .onError(
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
                          Text(
                            'Selecciona un proyecto',
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 15.sp,
                              color: Color(0xFF566B8C),
                            ),
                          ),
                          SizedBox(height: 20.sp),
                          for (int index = 0; index < projects.length; index++)
                            ProjectCard(
                              project: projects[index],
                              onTap: () async {
                                openProject(
                                  context,
                                  project: projects[index],
                                  index: index,
                                );
                              },
                              stream: StreamBuilder<Map<String, ProjectCache>>(
                                stream: provider.cacheStream,
                                builder: (context,
                                    AsyncSnapshot<Map<String, ProjectCache>>
                                        snapshot) {
                                  if (!snapshot.hasData) {
                                    return SizedBox.shrink();
                                  }
                                  final cache = snapshot.data;

                                  if (cache == null) return SizedBox.shrink();

                                  if (!cache.containsKey(
                                      projects[index].getProjectCode))
                                    return SizedBox.shrink();

                                  if (cache[projects[index].getProjectCode] ==
                                      null) return SizedBox.shrink();

                                  if (cache[projects[index].getProjectCode]
                                          ?.porPublicar ==
                                      null) return SizedBox.shrink();

                                  if (cache[projects[index].getProjectCode]
                                          ?.porPublicar ??
                                      false)
                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Image.asset(
                                                'assets/img/Desglose/Home/btn-por-publicar.png'),
                                          )
                                        ],
                                      ),
                                    );

                                  return SizedBox.shrink();
                                },
                              ),
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

  Future<void> openProject(
    context, {
    nombreIcono,
    required Project project,
    required int index,
  }) async {
    try {
      final provider = Provider.of<ProjectsProvider>(context, listen: false);
      provider.setCurrentProjectCode(project.codigoproyecto);
      loadingDialog(context);

      final DatosAlimentacion? detail =
          await provider.getProjectDetail(project.codigoproyecto);

      Navigator.pop(context);

      if (detail == null) {
        Toast.show(
            "Lo sentimos, este proyecto no fue sincronizado anteriormente",
            duration: 3,
            gravity: Toast.bottom);
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProyectScreen.init(),
        ),
      );
    } catch (e) {
      // TODO
      Toast.show("Algo salió mal", duration: 3, gravity: Toast.bottom);
    }
  }
}
