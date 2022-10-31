import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerDetallerActivoWidget extends StatelessWidget {
  const ShimmerDetallerActivoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: (361).sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skelton(width: 100.sp, height: 20.sp),
          SizedBox(height: 10.sp),
          Skelton(width: 210.sp, height: 20.sp),
          SizedBox(height: 20.sp),
          ...List.generate(3, (int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 7.5.sp),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skelton(width: 100.sp, height: 20.sp),
                  SizedBox(width: 40.sp),
                  Skelton(width: 150.sp, height: 20.sp),
                ],
              ),
            );
          }),
          SizedBox(height: 30.sp),
          Skelton(width: double.infinity, height: 120.sp),
        ],
      ),
    );
  }
}
