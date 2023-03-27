import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/lista_proyectos_aom_page/bloc/aom_projects_bloc.dart';
import 'package:appalimentacion/ui/widgets/cargando.dart';
import 'package:appalimentacion/ui/widgets/proyecto_card.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

const titleColor = Color(0xff444444);

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
          const HeaderProfileWidget(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 280, left: 20.0, right: 20.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                BlocBuilder<AomProjectsBloc, AomProjectsState>(
                  builder: (context, state) {
                    if (state.projects.isEmpty) {
                      return const _NoProjects();
                      // TODO Escuchar conectividad y volver a intentar obtener proyectos
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text(
                              'Proyectos AOM ',
                              style: TextStyle(
                                fontFamily: "mulish",
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color(0xFF000000),
                              ),
                            ),
                            Text(
                              '(${state.projects.length} proyectos)',
                              style: const TextStyle(
                                fontFamily: "mulish",
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: ColorTheme.primary,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                context
                                    .read<AomProjectsBloc>()
                                    .add(AomProjectsGetProjects());
                              },
                              child: const Icon(Icons.replay_outlined),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        const AutoSizeText(
                          'Selecciona un proyecto para gestionar el inventario',
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "montserrat",
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                            color: Color(0xFF566B8C),
                          ),
                        ),
                        const SizedBox(height: 20),
                        for (final project in state.projects)
                          ProjectCard(
                            project: project,
                            // TODO
                            detailSyncronized: true,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.aomDetalle,
                                arguments: {
                                  'project': project,
                                  'projectCode': project.codigoproyecto,
                                },
                              );
                            },
                            stream: Container(),
                          ),
                      ],
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                margin:
                    const EdgeInsets.only(bottom: 20.0, top: 20.0, right: 20.0),
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
