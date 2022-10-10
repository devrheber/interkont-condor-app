import 'dart:convert';
import 'dart:io';
import 'package:appalimentacion/ui/report_progress/cuerpo/cuartoPaso/local_widgets/imagen_caja.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/cuartoPaso/local_widgets/seleccionar_foto_documentos.dart';
import 'package:appalimentacion/utils/base64_to_file.dart';
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
  @override
  void initState() {
    super.initState();
    {
      loadImageToListaImagenes();
    }
  }

  Future obtenerImagen(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);

    var filesFotosComplementarias = contenidoWebService[0]['proyectos']
        [posListaProySelec]['datos']['filesFotosComplementarias'];
    if (filesFotosComplementarias == null) {
      contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
          ['filesFotosComplementarias'] = [];
    }
    Map<String, Object> listaArmada = {
      "image": base64Encode(File(picked.path).readAsBytesSync()),
      "nombre": "imagenesComplementarias",
      "tipo": "jpeg",
      "posicion": filesFotosComplementarias.length,
    };
    contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['filesFotosComplementarias']
        .add(listaArmada);
    await loadImageToListaImagenes();
    setState(() {});
  }

  Future<void> removerImagen(int posicion) async {
    //remover imagen de la lista y asignar posición anterior
    contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['filesFotosComplementarias']
        .removeWhere((element) => element['posicion'] == posicion);
    contenidoWebService[0]['proyectos'][posListaProySelec]['datos']
            ['filesFotosComplementarias']
        .forEach((element) {
      element['posicion'] = contenidoWebService[0]['proyectos']
              [posListaProySelec]['datos']['filesFotosComplementarias']
          .indexOf(element);
    });
    listaImagenes.removeWhere((element) => element['posicion'] == posicion);
    listaImagenes.forEach((element) { 
      element['posicion'] = listaImagenes.indexOf(element);
    }); 
    await loadImageToListaImagenes();

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

  Future<void> loadImageToListaImagenes() async {
    var filesFotosComplementarias = contenidoWebService[0]['proyectos']
        [posListaProySelec]['datos']['filesFotosComplementarias'];

    if (filesFotosComplementarias != null &&
        filesFotosComplementarias.isNotEmpty) {
      await filesFotosComplementarias.forEach((element) async {
        var name = element['nombre'] + element['posicion'].toString();
        var file = await base64StringToFile(
            image: element['image'], name: name, extension: element['tipo']);
        //* si listaImagenes contiene el mismo nombre de archivo, no lo agrega

        if (!listaImagenes.any((imagen) => imagen['nombre'] == name)) {
          listaImagenes.add({
            "image": file,
            "nombre": file.path.split('/').last.split('.').first,
            "posicion": element['posicion']
          });
        }

        setState(() {});
      });
    }
  }
}
