import 'dart:io';

import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:toast/toast.dart';

class DocumentosAdicionales extends StatefulWidget {
  DocumentosAdicionales({Key key}) : super(key: key);
  @override
  State<DocumentosAdicionales> createState() => _DocumentosAdicionalesState();
}

class _DocumentosAdicionalesState extends State<DocumentosAdicionales> {
  List<File> listaDocumentos = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20.sp,
      spacing: 20.sp,
      children: <Widget>[
        ...listaDocumentos.asMap().entries.map((image) {
          return ImagenCaja(
            isDocumento: getTypeFile(image.value),
            isMaxLimit: true,
            file: image.value,
            onRemoveImageTap: () {
              removerDocumento(image.key);
            },
          );
        }).toList(),
        ImagenCaja(
          isDocumento: false,
          isMaxLimit: true,
          file: null,
          onTap: () => agregarDocumento(),
        ),
      ],
    );
  }

  Future<void> agregarDocumento() async {
    //file picker
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
        File file = File(result.files.single.path);
        setState(() => listaDocumentos.add(file));
      }
      return;
    }
  }

  void removerDocumento(int key) {
    setState(() => listaDocumentos.removeAt(key));
  }
}
