import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/proyecto/project_screen.dart';
import 'package:appalimentacion/ui/widgets/cargando.dart';
import 'package:appalimentacion/ui/widgets/proyecto_card.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import 'bloc/projects_bloc.dart';

const titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  const ProyectosContenido._({Key? key}) : super(key: key);

  static Widget init() {
    return BlocProvider(
      create: (context) => ProjectsBloc(
        filesPersistentCacheRepository: context.read(),
        projectsCacheRepository: context.read(),
        projectRepository: context.read(),
      )
        ..add(ProjectsStream())
        ..add(ProjectsDetailsStream())
        ..add(ProjectsCacheStream())
        ..add(FetchRemoteProjects()),
      child: const ProyectosContenido._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocListener<ProjectsBloc, ProjectsState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.isLoading) {
          LoadingDialog.show(context);
        }
        if (!state.isLoading) {
          LoadingDialog.hide(context);
        }
        if (state.message.isNotEmpty) {
          SnackBar snackBar = SnackBar(
            content: Text(state.message),
            backgroundColor: ColorTheme.primaryTint,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      child: Stack(
        children: <Widget>[
          const HeaderProfileWidget(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 280, left: 20.0, right: 20.0),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProjectsBloc>().add(FetchRemoteProjects());
              },
              child: BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  if (state.projects.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                      ),
                    );
                  }

                  final projects = state.projects;
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text(
                                'Mis Proyectos ',
                                style: TextStyle(
                                  fontFamily: "mulish",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              Text(
                                '(${projects.length} ${projects.length == 1 ? 'proyecto' : 'proyectos'})',
                                style: const TextStyle(
                                  fontFamily: "mulish",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: ColorTheme.primary,
                                ),
                              ),
                              const Expanded(child: SizedBox.shrink()),
                              InkWell(
                                onTap: () => context
                                    .read<ProjectsBloc>()
                                    .add(FetchRemoteProjects()),
                                child: const Icon(Icons.replay_outlined),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Selecciona un proyecto',
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                              color: Color(0xFF566B8C),
                            ),
                          ),
                          const SizedBox(height: 20),
                          for (int index = 0; index < projects.length; index++)
                            ProjectCard(
                              project: projects[index],
                              detailSyncronized: !state.details
                                  .containsKey(projects[index].getProjectCode),
                              onTap: () async {
                                final detail = state
                                    .details[projects[index].getProjectCode];

                                context
                                    .read<ProjectsBloc>()
                                    .add(SetCurrentProjectCode(
                                      projects[index].codigoproyecto,
                                    ));

                                await Navigator.of(context).push(
                                    ProyectScreen.route(
                                        project: state.projects[index],
                                        detail: detail,
                                        cache: state.cache[state
                                            .projects[index].getProjectCode]));
                              },
                              stream: BlocBuilder<ProjectsBloc, ProjectsState>(
                                builder: (context, state) {
                                  final cache = state.cache;

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
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
