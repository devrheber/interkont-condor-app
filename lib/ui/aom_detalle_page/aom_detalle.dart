import 'package:appalimentacion/domain/models/categoria_obra.dart';
import 'package:appalimentacion/domain/models/project.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/aom_detalle_page/cubit/aomdetail_cubit.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:appalimentacion/ui/widgets/shimmer_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AomDetallePage extends StatelessWidget {
  const AomDetallePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Project project = arguments['project'];

    final int projectCode = arguments['projectCode'];

    return BlocProvider(
      lazy: false,
      create: (context) => AomDetailCubit(
        aomProjectsRepository: context.read(),
        aomProjectsApi: context.read(),
      )..loadData(projectCode),
      child: AomDetalleView(project),
    );
  }
}

class AomDetalleView extends StatelessWidget {
  const AomDetalleView(
    this.proyecto, {
    Key? key,
  }) : super(key: key);

  final Project proyecto;

  @override
  Widget build(BuildContext context) {
    final state = context.select((AomDetailCubit cubit) => cubit.state);

    return FondoHome(
      body: Stack(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 60),
                child: Stack(
                  children: <Widget>[
                    _TitleSubtitle(
                      nombre: proyecto.nombreproyecto,
                      objeto: proyecto.objeto,
                    ),
                    _ImageURL(
                      imageURL: proyecto.imagencategoria,
                    ),
                  ],
                ),
              ),
              customedAppBar(
                title: '',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 306, left: 28, right: 28),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: <Widget>[
                      _TitleContent(
                        title: 'Operador AOM',
                        content: state.contratista.contratista,
                      ),
                      const Divider(),
                      _TitleContent(
                        title:
                            'Fecha de Finalización de Administración de Recursos',
                        content: state.generalData?.fechaFinalizacionRecursos ??
                            '--',
                      ),
                      const Divider(),
                      _TitleContent(
                        title: 'Fecha de Inicio AOM',
                        content: state.generalData?.fechaInicio ?? '--',
                      ),
                      const Divider(),
                      _TitleContent(
                        title: 'Fecha de Recepción\nde los Activos',
                        content:
                            state.generalData?.fechaRecepcionActivos ?? '--',
                      ),
                      const Divider(),
                      _TitleContent(
                        title: 'Cantidad de Activos',
                        content: '${state.clasifications.length}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Selecciona una categoría de activos para reportar la actualización',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                //rounded elevated button
                const _Clasifications(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Clasifications extends StatelessWidget {
  const _Clasifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    final state = context.select((AomDetailCubit cubit) => cubit.state);
    if (kDebugMode) print(state.status);

    if (state.status == AomDetailStatus.loading) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (_, int index) {
          return ShimmerButton(delay: Duration(milliseconds: index * 30));
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      );
    }

    if (state.status == AomDetailStatus.failure &&
        state.clasifications.isEmpty) {
      return DefaultTextStyle(
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        child: Column(children: [
          // TODO Put an image
          const Text('Ocurrió un error al obtener las categorías.'),
          const SizedBox(height: 10),
          Text(state.errorResponse?['message']),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                if (state.generalData?.obraId == null) {
                  Toast.show(
                    'No es posible recargar. Salga y vuelva a esta pantalla',
                    duration: 6,
                  );
                  return;
                }

                context
                    .read<AomDetailCubit>()
                    .loadData(state.generalData!.obraId!);
              },
              child: const Text(
                'Reintentar',
                style: TextStyle(color: Colors.red),
              ))
        ]),
      );
    }

    return Column(
      children: [
        Visibility(
          visible: state.isValidateClasificacionActivos,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'No se pudo obtener algunos objetos de tipo "clasificacionActivos"',
              style: (TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        ...state.clasifications.map(
          (e) {
            String text = e.clasificacionActivos == ClasificacionActivos.empty
                ? '--'
                : e.clasificacionActivos.descripcion;
            const int enRevision = 1;
            bool pending = e.estadoClasificacion == enRevision;
            // TODO Step
            int step = 1;
            return ActivoGeneral(
              pending: pending,
              text: text,
              disable: e.clasificacionActivos == ClasificacionActivos.empty,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.aomDetalleCategoria,
                  arguments: {
                    'vidaUtilEnMeses': e.clasificacionActivos.vidaUtil,
                    'projectCode': state.generalData!.obraId,
                    'nombre': text,
                    'pendiente': pending,
                    'paso': step,
                    'clasificationId': e.id,
                    'categoryId': e.clasificacionActivos.id,
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}

class ActivoGeneral extends StatelessWidget {
  const ActivoGeneral({
    Key? key,
    this.disable = false,
    required this.pending,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final bool disable;
  final bool pending;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      child: IgnorePointer(
        ignoring: disable || pending,
        child: ElevatedButton(
          onPressed: onTap,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              children: pending
                  ? [
                      const TextSpan(text: '\n'),
                      const WidgetSpan(
                        child: Icon(
                          Icons.error_outline,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      const TextSpan(
                        text: 'Pendiente por Revisión',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: (!disable && !pending)
                ? ColorTheme.primaryTint
                : ColorTheme.mediumshade,
            onPrimary: ColorTheme.tertiaryShade,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleContent extends StatelessWidget {
  const _TitleContent({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.93,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageURL extends StatelessWidget {
  const _ImageURL({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  final String imageURL;

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
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageURL,
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

class _TitleSubtitle extends StatelessWidget {
  const _TitleSubtitle({
    Key? key,
    required this.nombre,
    required this.objeto,
  }) : super(key: key);

  final String nombre;
  final String objeto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 204,
      padding: const EdgeInsets.only(top: 1.0, bottom: 10.0),
      margin: const EdgeInsets.only(top: 40, right: 28, left: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                nombre,
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
            const SizedBox(
              height: 7,
            ),
            Container(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: Center(
                child: Text(
                  objeto,
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
  }
}
