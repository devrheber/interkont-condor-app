import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/proyecto/project_screen.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/last_step/noInternet.dart';
import 'package:appalimentacion/ui/widgets/cargando.dart';
import 'package:appalimentacion/ui/widgets/proyecto_card.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'projects_provider.dart';

const titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  const ProyectosContenido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final projectsProvider = Provider.of<ProjectsProvider>(context);

    ToastContext().init(context);
    return Stack(
      children: <Widget>[
        const HeaderProfileWidget(),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 280.sp, left: 20.0, right: 20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              StreamBuilder<List<Project>>(
                  stream: projectsProvider.projectsStream,
                  builder: (context, AsyncSnapshot<List<Project>> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  height: 150.0,
                                  margin: const EdgeInsets.only(
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
                                child: const Icon(Icons.replay_outlined),
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
                              color: const Color(0xFF566B8C),
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
                                    return const SizedBox.shrink();
                                  }
                                  final cache = snapshot.data;

                                  if (cache == null) {
                                    return const SizedBox.shrink();
                                  }

                                  if (!cache.containsKey(
                                      projects[index].getProjectCode)) {
                                    return const SizedBox.shrink();
                                  }

                                  if (cache[projects[index].getProjectCode] ==
                                      null) return const SizedBox.shrink();

                                  if (cache[projects[index].getProjectCode]
                                          ?.porPublicar ==
                                      null) return const SizedBox.shrink();

                                  if (cache[projects[index].getProjectCode]
                                          ?.porPublicar ??
                                      false) {
                                    return Container(
                                      margin: const EdgeInsets.only(
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
                                  }

                                  return const SizedBox.shrink();
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
