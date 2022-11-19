import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_category_detail_cubit.dart';

import 'package:appalimentacion/ui/aom_report_step_3/bloc/aom_report_step_3_bloc.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:toast/toast.dart';
import '../widgets/widgets.dart';

class AomReportStep3Page extends StatelessWidget {
  const AomReportStep3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AomReportStep3Bloc(),
      child: const AomReportStep3View(),
    );
  }
}

class AomReportStep3View extends StatelessWidget {
  const AomReportStep3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocListener<AomReportStep3Bloc, AomReportStep3State>(
      listener: (context, state) {
        if (state.status == AomReportStep3Status.failure) {
          Toast.show(state.responseMessage);
        }

        if (state.status == AomReportStep3Status.success) {
          Toast.show(state.responseMessage);
        }
      },
      child: BlocBuilder<AomReportStep3Bloc, AomReportStep3State>(
        builder: (context, state) {
          Future<void> forwardMethod() async {
            const String __requiredFileKey__ = 'image';
            if (!state.files.containsKey(__requiredFileKey__)) {
              Toast.show('Debe agregar una imagen');
              return;
            }

            final confirm = await DialogHelper.showConfirmDialog(
              context,
              child: ConfirmDialog(
                  description:
                      '¿Está seguro de registrar la actualización AOM?',
                  continueButtonText: 'Aceptar',
                  cancelButtonText: 'Cancelar'),
            );

            if (confirm != true) return;

            // return;
            final data = context.read<AomReportCubit>().state.getDataToSend();

            final dynamic result = await Navigator.pushNamed(
              context,
              AppRoutes.aomLastStep,
              arguments: {
                'data': data,
                'files': state.files,
              },
            );

            if (result?['message'] != null) {
              Toast.show(result?['message'], duration: 5);
            }

            // context.read<AomReportStep3Bloc>().add(SendDataEvent(data));
          }

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 265.h, left: 28.sp, right: 28.sp),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Text(
                            'Subir una Imagen o Video',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.primary,
                            ),
                          ),
                          SizedBox(height: 30.sp),
                          Center(
                            child: FileUploadWidget(),
                          ),
                          SizedBox(height: 100.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AomReportCustomBottomWidget(
                forwardMethod: () => forwardMethod(),
                forwardTitle: 'Finalizar Actualización',
                backMethod: () {
                  context.read<AomReportCubit>().setStep(2);
                },
                backTitle: 'Retroceder',
              ),
            ],
          );
        },
      ),
    );
  }
}
