import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appalimentacion/theme/color_theme.dart';
import '../widgets/widgets.dart';

class AomReportStep3Page extends StatelessWidget {
  const AomReportStep3Page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
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
            Navigator.pushNamed(context, AppRoutes.aomLastStep);
          },
          forwardTitle: 'Finalizar Actualización',
        ),
      ],
    );
  }
}
