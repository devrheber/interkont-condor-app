import 'dart:io';
import 'package:appalimentacion/domain/models/tipo_doc_model.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/fouth_step_provider.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/utils/seleccionar_foto_documentos.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class DocumentosAdicionales extends StatelessWidget {
  const DocumentosAdicionales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepService = context.read<FourthStepProvider>();
    final documents = context.watch<FourthStepProvider>().additionalDocuments;

    ToastContext().init(context);
    
    var textStyle = TextStyle(
      fontFamily: 'montserrat',
      fontSize: 14.sp,
      color: Color(0xFF556A8D),
      fontWeight: FontWeight.w400,
    );

    Future<void> agregarDocumento() async {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null) return;

      //if result is greater than 20mb show error message
      if (result.files.single.size > 20000000) {
        Toast.show("El archivo no puede ser mayor a 20MB",
            duration: 3, gravity: Toast.bottom);

        return;
      }

      // TODO Use try catch

      File file = File(result.files.single.path!);
      fourthStepService.addAdditionalDocument(file);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: 20.sp,
          spacing: 20.sp,
          children: [
            for (final doc in documents)
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: ImagenCaja(
                        isDocumento: getTypeFile(doc.file),
                        isMaxLimit: true,
                        file: doc.file!,
                        onRemoveImageTap: () {
                          fourthStepService.removeAdditionalDocument(doc);
                        },
                      )),
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
                        doc.typeName ?? '',
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
              ),
          ],
        ),
        Row(
          children: [
            ImagenCaja(
                isDocumento: false,
                isMaxLimit: true,
                file: null,
                onTap: () async {
                  if (fourthStepService.tipoDocValue == null) {
                    Toast.show('Seleccione un tipo de documento',
                        gravity: Toast.bottom);
                    return;
                  }
                  await agregarDocumento();
                }),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18.sp),
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppTheme.cuarto.withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<TipoDoc>(
                    isExpanded: true,
                    hint: AutoSizeText(
                      'Seleccione un documento',
                      maxLines: 2,
                    ),
                    style: textStyle,
                    value: fourthStepService.tipoDocValue,
                    items: fourthStepService.listaTipoDoc.map((TipoDoc value) {
                      return DropdownMenuItem<TipoDoc>(
                        value: value,
                        child: AutoSizeText(
                          value.nombre,
                          maxLines: 2,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      fourthStepService.tipoDocValue = value;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
