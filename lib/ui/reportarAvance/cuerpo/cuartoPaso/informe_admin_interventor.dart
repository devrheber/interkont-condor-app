import 'dart:io';

import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:toast/toast.dart';

class InformeAdminInterventor extends StatefulWidget {
  InformeAdminInterventor({Key key}) : super(key: key);
  @override
  State<InformeAdminInterventor> createState() =>
      _InformeAdminInterventorState();
}

class _InformeAdminInterventorState extends State<InformeAdminInterventor> {
  File documento;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20.sp,
      spacing: 20.sp,
      children: <Widget>[
        ImagenCaja(
          isDocumento: getTypeFile(documento),
          isMaxLimit: true,
          file: documento,
          onTap: () => agregarDocumento(),
          onRemoveImageTap: () => removerDocumento(),
        ),
      ],
    );
  }

  void removerDocumento() {
    setState(() => documento = null);
  }

  Future<void> agregarDocumento() async {
    final FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //if result is greater than 20mb show error message
      if (result.files.single.size > 20000000) {
           Toast.show(
          "El archivo no puede ser mayor a 20MB",
          context,
          duration: 3, 
          gravity: Toast.BOTTOM);
        return;
      } else {
        setState(() => documento = File(result.files.single.path));
      }
      return;
    }
  }

 
}
