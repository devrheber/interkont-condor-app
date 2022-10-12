import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/utils/base64_to_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../globales/variables.dart';
import 'local_widgets/imagen_caja.dart';
import 'local_widgets/seleccionar_foto_documentos.dart';

class FotoPrincipal extends StatefulWidget {
  const FotoPrincipal({Key key}) : super(key: key);

  @override
  _FotoPrincipalState createState() => _FotoPrincipalState();
}

class _FotoPrincipalState extends State<FotoPrincipal> {
  String base64Image;
  @override
  void initState() {
    super.initState();
    loadImageToListaImagenes();
  }

  Future<void> loadImageToListaImagenes() async {
    String fileFotoPrincipal = contenidoWebService[0]['proyectos']
        [posListaProySelec]['datos']['fileFotoPrincipal'];
    File file = await base64StringToFile(
      image: fileFotoPrincipal,
      name: 'fotoPrincipal',
    );
    if (file != null) {
      context.read<ReportarAvanceProvider>().listaImagenes.add(file);
    }
    setState(() {});
  }

  Future<void> obtenerImagen(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);

    if (picked == null) return;

    contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['fileFotoPrincipal'] =
        base64Encode(File(picked.path).readAsBytesSync());
    await loadImageToListaImagenes();
  }

  void removerImagen() {
    setState(() {
      contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
          ['fileFotoPrincipal'] = null;
      context.read<ReportarAvanceProvider>().listaImagenes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final listaImagenes = context.watch<ReportarAvanceProvider>().listaImagenes;
    return Container(
      child: Wrap(
        children: <Widget>[
          ImagenCaja(
            file: listaImagenes.isEmpty ? null : listaImagenes.first,
            onTap: () {
              seleccionarGaleriaCamara(
                context,
                onCameraTap: () => obtenerImagen(ImageSource.camera),
                onGalleryTap: () => obtenerImagen(ImageSource.gallery),
              );
            },
            onRemoveImageTap: () => removerImagen(),
          ),
        ],
      ),
    );
  }
}
