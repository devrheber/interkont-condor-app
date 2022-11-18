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
      create: (context) =>
          AomReportStep3Bloc(aomProjectsRepository: context.read()),
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
          final snackBar = SnackBar(content: Text('Error'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state.validateStatus == ValidationStatus.failure) {
          Toast.show('invalid data');
        }

        if (state.validateStatus == ValidationStatus.success) {
          Toast.show('send data');
        }
      },
      child: BlocBuilder<AomReportStep3Bloc, AomReportStep3State>(
        builder: (context, state) {
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
                forwardMethod: () {
                  final bloc = context.read<AomReportStep3Bloc>();

                  // TODO Validate
                  bloc.add(ValidateData());
                  // TODO Show Confirmation before send data

                  // Navigator.pushNamed(context, AppRoutes.aomLastStep);
                  // context
                  //     .read<AomReportStep3Bloc>()
                  //     .add(UploadFileEvent(1, 'imagen de prueba', 2979));
                },
                forwardTitle: 'Finalizar Actualización',
              ),
            ],
          );
        },
      ),
    );
  }
}
