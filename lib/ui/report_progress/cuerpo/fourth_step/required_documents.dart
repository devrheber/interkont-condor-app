import 'dart:io';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/fouth_step_provider.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'local_widgets/imagen_caja.dart';

class RequiredDocuments extends StatelessWidget {
  const RequiredDocuments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepService = context.read<FourthStepProvider>();
    final requiredDocuments =
        context.watch<FourthStepProvider>().requiredDocuments;

    ToastContext().init(context);

    Future<void> agregarDocumento({required int index}) async {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      //if result is greater than 20mb show error message
      if (result.files.single.size > 20000000) {
        Toast.show("El archivo no puede ser mayor a 20MB",
            duration: 3, gravity: Toast.bottom);
        return;
      }

      // TODO Use try catch

      final file = File(result.files.single.path!);
      fourthStepService.addDocument(file, index: index);
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requiredDocuments.length,
      shrinkWrap: true,
      itemBuilder: (_, int index) {
        final item = requiredDocuments[index];
        return Row(
          children: <Widget>[
            ImagenCaja(
              isDocumento: getTypeFile(item.file),
              isMaxLimit: true,
              file: item.file,
              onTap: () => agregarDocumento(index: index),
              onRemoveImageTap: () {
                fourthStepService.removeDocument(index);
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18.sp),
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppTheme.cuarto.withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: AutoSizeText(
                  item.typeName ?? '',
                  maxLines: 10,
                  style: TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 14.sp,
                    color: Color(0xFF556A8D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (_, int index) {
        return SizedBox(height: 20.sp);
      },
    );
  }
}
