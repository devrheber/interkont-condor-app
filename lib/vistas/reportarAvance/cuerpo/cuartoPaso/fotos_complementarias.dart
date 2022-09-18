import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../globales/variables.dart';

class FotosComplementarias extends StatefulWidget {
  final int numeroFotos;

  FotosComplementarias({Key key, this.numeroFotos}) : super(key: key);
  @override
  _FotosComplementariasState createState() => _FotosComplementariasState();
}

class _FotosComplementariasState extends State<FotosComplementarias> {
  List listaImagenes = [];

  Future obtenerImagen(ImageSource source) async {
    final picked = await ImagePicker().getImage(source: source);

    int currentPosition = listaImagenes.length;
    listaImagenes
        .add({'image': File(picked.path), 'posicion': currentPosition});
    File image = listaImagenes[currentPosition]['image'];
    Map<String, Object> listaArmada = {
      "image": base64Encode(image.readAsBytesSync()),
      "nombre": "imagenesComplementarias",
      "tipo": "jpeg",
      "posicion": listaImagenes.length - 1
    };
    var filesFotosComplementarias = contenidoWebService[0]['proyectos']
            [posicionListaProyectosSeleccionado]['datos']
        ['filesFotosComplementarias'];

    if (filesFotosComplementarias == null) {
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
          ['datos']['filesFotosComplementarias'] = [];
    }
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['filesFotosComplementarias']
        .add(listaArmada);
    setState(() {});
  }

  void removerImagen(int posicion) {
    //remover imagen de la lista y asignar posición anterior
    listaImagenes.removeWhere((element) => element['posicion'] == posicion);
    listaImagenes.forEach((element) {
      element['posicion'] = listaImagenes.indexOf(element);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20.sp,
      spacing: 20.sp,
      children: <Widget>[
        //lista las imagenes que se encuentran grabadas
        ...listaImagenes.asMap().entries.map((image) {
          return ImagenCaja(
            file: image.value['image'],
            onRemoveImageTap: () {
              removerImagen(image.value['posicion']);
            },
          );
        }).toList(),
        ImagenCaja(
          onTap: () {
            seleccionarGaleriaCamara(
              context,
              onCameraTap: () => obtenerImagen(ImageSource.camera),
              onGalleryTap: () => obtenerImagen(ImageSource.gallery),
            );
          },
        ), 
      ],
    );
  }
}
