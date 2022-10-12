import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/ui/widgets/cargando.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../globales/colores.dart';
import '../../globales/variables.dart';
import '../../theme/color_theme.dart';
import '../proyecto/project_screen.dart';

final titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectsProvider = Provider.of<ProjectsProvider>(context);
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
                        context.read<AuthenticationProvider>().user.username,
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
                    final projects = snapshot.data;

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
                                  await projectsProvider.getRemoteProjects();
                                  Navigator.pop(context);
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
                          for (int i = 0; i < projects.length; i++)
                            ProjectCard(project: projects[i], index: i),
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

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key key, @required this.project, @required this.index})
      : super(key: key);

  final Project project;
  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProjectsProvider>();
    return Card(
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              openProject(
                context,
                project: project,
                index: index,
              );
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 1.sp, top: 1.sp),
              padding: EdgeInsets.only(
                  top: 24.sp, bottom: 24.sp, left: 28.sp, right: 4.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Spacer(),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 50, maxHeight: 50),
                        child: ClipOval(
                          child: conexionInternet
                              ? CachedNetworkImage(
                                  imageUrl: project.imagencategoria,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Image.asset(
                                  'assets/img/Desglose/Demas/question.png',
                                ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 50,
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
                                      project.nombreCategoriaUpperCase,
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.sp,
                                        letterSpacing: 0.4,
                                        color: Color(
                                          project.titleColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                project.nombreproyecto,
                                style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: Color(0xFF000000),
                                ),
                              ),
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
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 0.3,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              child: AutoSizeText(
                                                project.projectValueRounded,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: "montserrat",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.sp,
                                                  letterSpacing: 0.4,
                                                  height: 0.9,
                                                  color: Color(0xFF808080),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      width: 0.3,
                                                      color:
                                                          Color(0xFFFF000000),
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    project.percentageByValue,
                                                    style: TextStyle(
                                                      fontFamily: "montserrat",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.sp,
                                                      letterSpacing: 0.4,
                                                      height: 0.9,
                                                      color: Color(0xFF808080),
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
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Image.asset(
                                                    'assets/img/Desglose/Home/${project.trafficLightColorValue}.png',
                                                    height: 19.sp,
                                                    width: 50.95.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<Map<String, ProjectCache>>(
                      stream: provider.cacheStream,
                      builder: (context,
                          AsyncSnapshot<Map<String, ProjectCache>> snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        }

                        final cache = snapshot.data;

                        if (cache != null) return SizedBox.shrink();

                        if (cache[project.codigoproyecto.toString()] != null)
                          return SizedBox.shrink();

                        if (cache[project.codigoproyecto.toString()]
                            .porPublicar)
                          return Container(
                            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Image.asset(
                                        'assets/img/Desglose/Home/btn-por-publicar.png'))
                              ],
                            ),
                          );

                        return SizedBox.shrink();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openProject(
    context, {
    nombreIcono,
    @required Project project,
    @required int index,
  }) async {
    final provider = Provider.of<ProjectsProvider>(context, listen: false);

    loadingDialog(context);
    final detail =
        await provider.getProjectDetail(project.codigoproyecto, index: index);
    Navigator.pop(context);

    if (detail == null) {
      Toast.show("Lo sentimos, este proyecto no fue sincronizado anteriormente",
          context,
          duration: 3, gravity: Toast.BOTTOM);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProyectoScreen.init(
          project: project,
        ),
      ),
    );
  }
}
