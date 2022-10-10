import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/ui/report_progress/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:appalimentacion/utils/base64_to_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../globales/variables.dart';

class FotoPrincipal extends StatefulWidget {
  final int numeroFotos;
  FotoPrincipal({Key key, this.numeroFotos}) : super(key: key);
  @override
  _FotoPrincipalState createState() => _FotoPrincipalState();
}

class _FotoPrincipalState extends State<FotoPrincipal> {
  List<File> listaImagenes = [];

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
    if (file != null) listaImagenes.add(file);
    setState(() {});
  }

  Future<void> obtenerImagen(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);

    contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['fileFotoPrincipal'] =
        base64Encode(File(picked.path).readAsBytesSync());
    await loadImageToListaImagenes();
  }

  void removerImagen() {
    setState(() {
      contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
          ['fileFotoPrincipal'] = null;
      listaImagenes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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

  // onPressed: obtenerImagenCamara,
}
