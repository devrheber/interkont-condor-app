import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/ui/proyecto/bloc/project_detail_bloc.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/last_step/last_step.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_screen.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../report_progress/report_progress_screen.dart';
import '../widgets/home/custom_bottom_navigation_bar.dart';
import '../widgets/home/fondoHome.dart';
import 'contenido.dart';

class ProyectScreen extends StatelessWidget {
  const ProyectScreen._();

  static Widget init({
    required Project project,
    required DatosAlimentacion detail,
    required ProjectCache? cache,
  }) =>
      BlocProvider(
        create: (context) => ProjectDetailBloc(
          projectRepository: context.read(),
          projectsCacheRepository: context.read(),
          project: project,
          detail: detail,
          cache: cache,
        )
          ..add(EstablecerPeriodoSeleccionado())
          ..add(SyncDetail()),
        child: const ProyectScreen._(),
      );

  static Route<void> route({
    required Project project,
    required DatosAlimentacion detail,
    required ProjectCache? cache,
  }) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: AppRoutes.projectDetail),
      builder: (_) => init(
        project: project,
        detail: detail,
        cache: cache,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectDetailBloc, ProjectDetailState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          SnackBar snackBar = SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
          final project = state.project;

          ToastContext().init(context);

          Future<void> goToNextScreen() async {
            if (!kDebugMode) {
              if (project.pendienteAprobacion) {
                Toast.show(
                    'Lo sentimos, este proyecto esta pendiente de aprobación, sincroniza una vez mas el proyecto, si cree que este ya ha sido aprobado',
                    duration: 5,
                    gravity: Toast.bottom);
                return;
              }
            }
            if (state.cache.synchronizationRequired) {
              Toast.show('Debe sincronizar el proyecto',
                  duration: 5, gravity: Toast.bottom);
              return;
            }

            if ((state.detail.periodos.isEmpty)) {
              Toast.show(
                  'Lo sentimos, este proyecto no tiene periodos que reportar',
                  duration: 3,
                  gravity: Toast.bottom);
              return;
            }
            // if (detailProvider.periodoSeleccionado == null) {
            if (!(state.detail.periodos.any((periodo) =>
                periodo.periodoId == state.periodoSeleccionado?.periodoId))) {
              Toast.show('Seleccione el periodo a reportar',
                  duration: 3, gravity: Toast.bottom);

              return;
            }

            if (state.cache.porPublicar) {
              final confirm = await DialogHelper.showConfirmDialog(
                context,
                child: const ConfirmDialog(
                    description: 'Este proyecto está pendiente de publicar.',
                    continueButtonText: 'Publicar ahora',
                    cancelButtonText: 'Editar avance'),
              );

              if (confirm == null) return;

              if (confirm) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LastStep.init()),
                );
                return;
              } else {
                context
                    .read<ProjectDetailBloc>()
                    .add(UpdateStepToPendingPublish());
              }
            }

            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ReportProgressScreen.init(
                      periodoSeleccionado: state.periodoSeleccionado!);
                },
              ),
            );

            if (result == null) return;

            if (result?['cancel'] == true) {
              context.read<ProjectDetailBloc>().add(ClearPeriodoSeleccionado());
            }
          }

          return WillPopScope(
            onWillPop: () async {
              context.read<ProjectDetailBloc>().add(CancelRequest());
              return true;
            },
            child: FondoHome(
              body: ProjectContent(
                project: state.project,
                projectCache: state.cache,
              ),
              bottomNavigationBar: CustomBottomNavigationBar(
                  colorFondo: const Color(0xff22B573),
                  primerBotonDesactivado: false,
                  segundoBotonDesactivado: project.pendienteAprobacion ||
                      (state.cache.synchronizationRequired),
                  txtPrimerBoton: null,
                  txtSegundoBoton: 'Reportar Avance',
                  heightSecondButton: 58.55,
                  accionPrimerBoton: null,
                  accionSegundoBoton: () => goToNextScreen()),
            ),
          );
        },
      ),
    );
  }
}
