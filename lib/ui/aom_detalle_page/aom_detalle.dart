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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                margin: EdgeInsets.only(top: 60.h),
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
            margin: EdgeInsets.only(top: 306.h, left: 28.sp, right: 28.sp),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Column(
                    children: <Widget>[
                      _TitleContent(
                        title: 'Operador AOM',
                        content: state.contratista.contratista,
                      ),
                      Divider(),
                      _TitleContent(
                        title:
                            'Fecha de Finalización de\Administración de Recursos',
                        content: state.generalData?.fechaFinalizacionRecursos ??
                            '--',
                      ),
                      Divider(),
                      _TitleContent(
                        title: 'Fecha de Inicio AOM',
                        content: state.generalData?.fechaInicio ?? '--',
                      ),
                      Divider(),
                      _TitleContent(
                        title: 'Fecha de Recepción\nde los Activos',
                        content:
                            state.generalData?.fechaRecepcionActivos ?? '--',
                      ),
                      Divider(),
                      _TitleContent(
                        title: 'Cantidad de Activos',
                        content: '${state.clasifications.length}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.sp),
                Text(
                  'Selecciona una categoría de activos para reportar la actualización',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12.sp,
                    // color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.sp),
                //rounded elevated button
                const _Clasifications(),
                SizedBox(height: 20.sp),
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
    if (kDebugMode) print('building clasifications');

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
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
      );
    }

    if (state.status == AomDetailStatus.failure &&
        state.clasifications.isEmpty) {
      return DefaultTextStyle(
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        child: Column(children: [
          // TODO Put an image
          Text('Ocurrió un error al obtener las categorías.'),
          SizedBox(height: 10.r),
          Text(state.errorResponse?['message']),
          SizedBox(height: 10.r),
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
              child: Text(
                'Reintentar',
                style: TextStyle(color: Colors.red),
              ))
        ]),
      );
    }

    // TODO Use FadeIn
    return Column(
      children: [
        ...state.clasifications.map(
          (e) {
            String text = e.clasificacionActivos.descripcion;
            // TODO pending, step
            bool pending = false;
            int step = 1;
            return ActivoGeneral(
              pending: pending,
              text: text,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.aomDetalleCategoria,
                  arguments: {
                    'projectCode': state.generalData!.obraId,
                    'nombre': text,
                    'pendiente': pending,
                    'paso': step,
                    'clasificationId': e.clasificacionActivos.id,
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
    required this.pending,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final bool pending;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      width: double.infinity,
      height: 50.h,
      child: IgnorePointer(
        ignoring: pending,
        child: ElevatedButton(
          onPressed: onTap,
          child:
              //rich text
              RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              children: pending
                  ? [
                      TextSpan(
                        text: '\n',
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.error_outline,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
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
            primary: !pending ? ColorTheme.primaryTint : ColorTheme.mediumshade,
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
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(width: 5.sp),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.93.sp,
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
                height: 77.sp,
                width: 77.sp,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageURL,
                    height: 77.sp,
                    width: 77.sp,
                    fit: BoxFit.fitWidth,
                    placeholder: (_, __) => Image.asset(
                      'assets/img/Desglose/Demas/question.png',
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img/Desglose/Demas/question.png',
                      height: 77.sp,
                      width: 77.sp,
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
      height: 204.h,
      padding: EdgeInsets.only(top: 1.0, bottom: 10.0),
      margin: EdgeInsets.only(top: 40.h, right: 28.sp, left: 28.sp),
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
        padding: EdgeInsets.only(top: 20.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 42.sp, right: 42.sp),
              child: Text(
                nombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Color(0xff556A8D),
                ),
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 19.sp, right: 19.sp),
              child: Center(
                child: Text(
                  objeto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
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
