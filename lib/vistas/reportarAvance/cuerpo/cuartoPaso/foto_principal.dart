import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
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

  Future<void> obtenerImagen(ImageSource source) async {
    final picked = await ImagePicker().getImage(source: source);
    listaImagenes.add(File(picked.path));
    File image = listaImagenes.first;

    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
        ['datos']['fileFotoPrincipal'] = base64Encode(image.readAsBytesSync());

    setState(() {});
  }

  void removerImagen() {
    setState(() {
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
          ['datos']['fileFotoPrincipal'] = null;
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
