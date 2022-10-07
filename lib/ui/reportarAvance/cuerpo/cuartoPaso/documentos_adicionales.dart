import 'dart:io';

import 'package:appalimentacion/data/remote/projects_impl.dart';
import 'package:appalimentacion/domain/models/tipo_doc_model.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/ui/reportarAvance/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  List<TipoDoc> listaTipoDoc = [];

  // TODO Manejar desde provider
  ProjectsImpl tipoDocService = ProjectsImpl();

  TipoDoc tipoDocValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarListaTipoDoc();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontFamily: 'montserrat',
      fontSize: 14.sp,
      color: Color(0xFF556A8D),
      fontWeight: FontWeight.w400,
    );
    return Column(
      // alignment: WrapAlignment.start,
      // runAlignment: WrapAlignment.start,
      // runSpacing: 20.sp,
      // spacing: 20.sp,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          runSpacing: 20.sp,
          spacing: 20.sp,
          children: [
            ...listaDocumentos.asMap().entries.map((image) {
              return Container(
                margin: EdgeInsets.only(bottom: 15),
                child: ImagenCaja(
                  isDocumento: getTypeFile(image.value),
                  isMaxLimit: true,
                  file: image.value,
                  onRemoveImageTap: () {
                    removerDocumento(image.key);
                  },
                ),
              );
            }).toList(),
          ],
        ),
        Row(
          children: [
            ImagenCaja(
              isDocumento: false,
              isMaxLimit: true,
              file: null,
              onTap: () => agregarDocumento(),
            ),
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
                    // itemHeight: 28.sp,
                    style: textStyle,

                    value: tipoDocValue,
                    items: listaTipoDoc.map((TipoDoc value) {
                      return DropdownMenuItem<TipoDoc>(
                        value: value,
                        child: AutoSizeText(
                          value.nombre,
                          maxLines: 2,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        tipoDocValue = value;
                      });
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

  Future<void> agregarDocumento() async {
    //file picker
    final FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //if result is greater than 20mb show error message
      if (result.files.single.size > 20000000) {
        Toast.show("El archivo no puede ser mayor a 20MB", context,
            duration: 3, gravity: Toast.BOTTOM);

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

  Future<void> cargarListaTipoDoc() async {
    listaTipoDoc = await tipoDocService.getTipoDoc();
    // recorrer listaTipoDoc e imprimir el nombre
    listaTipoDoc.forEach((element) {
      print(element.nombre);
    });
    setState(() {});
  }
}
