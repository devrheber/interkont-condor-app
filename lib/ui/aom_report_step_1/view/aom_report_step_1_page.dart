import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/aom_report_step_1/bloc/aom_category_detail_bloc.dart';
import 'package:appalimentacion/ui/widgets/shimmer_detalle_activo_widget.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';

class AomReportStep1Page extends StatelessWidget {
  const AomReportStep1Page._({
    Key? key,
  }) : super(key: key);

  static Widget init({
    Key? key,
    required int projectCode,
    required int clasificationId,
  }) {
    return BlocProvider(
      create: (context) => AomCategoryDetailBloc(
        aomProjectsRepository: context.read(),
        aomProjectsApi: context.read(),
      )..add(LoadDataEvent(projectCode, clasificationId)),
      child: AomReportStep1Page._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AomCategoryDetailBloc, AomCategoryDetailState>(
      buildWhen: ((previous, current) => previous.status != current.status),
      builder: (context, state) {
        if (state.status == AomCategoryDetailStatus.loading) {
          return Builder(builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (_, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.sp),
                      padding: EdgeInsets.only(
                        left: 15.sp,
                        right: 15.sp,
                        top: 20.45.sp,
                        bottom: 20.45.sp,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.13.sp),
                          color: ColorTheme.primary.withOpacity(0.05)),
                      child: ShimmerDetallerActivoWidget());
                },
                separatorBuilder: (_, int index) => SizedBox(height: 10.sp),
              ),
            );
          });
        }

        return FadeIn(
          duration: const Duration(milliseconds: 1500),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                AutoSizeText(
                  'Registre los cambios a reportar de cada activo de la lista',
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 15.sp,
                    color: Color(0xff444444),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.sp),
                for (final item in state.gestionAom) DetailCardWidget(item),
              ],
            ),
          ),
        );
      },
    );
  }
}
