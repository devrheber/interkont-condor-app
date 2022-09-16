import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../globales/variables.dart';

MemoryImage imageFromBase64String(String base64String) {
  return MemoryImage(
    base64Decode(base64String),
  );
}

class MostrarFotoSubida extends StatefulWidget {
  final int numeroFotos;

  MostrarFotoSubida({Key key, this.numeroFotos}) : super(key: key);
  @override
  _MostrarFotoSubidaState createState() => _MostrarFotoSubidaState();
}

class _MostrarFotoSubidaState extends State<MostrarFotoSubida> {
  File pickerImage;

  @override
  void initState() {}

  String base64Image;
  Future obtenerImagenCamara() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);

    pickerImage = File(picked.path);

    setState(() {
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
              ['datos']['fileFotoPrincipal'] =
          base64Encode(pickerImage.readAsBytesSync());
    });
  }

  Future obtenerImagenGaleria() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    pickerImage = File(picked.path);
    setState(() {
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
              ['datos']['fileFotoPrincipal'] =
          base64Encode(pickerImage.readAsBytesSync());
    });
  }

  void removerImagen() {
    setState(() {
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
          ['datos']['fileFotoPrincipal'] = '';
    });
  }

  void seleccionarGaleriaCamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Galeria'),
                    onTap: () =>
                        {Navigator.of(context).pop(), obtenerImagenGaleria()}),
                ListTile(
                  leading: Icon(FontAwesomeIcons.camera),
                  title: Text('Camara'),
                  onTap: () =>
                      {Navigator.of(context).pop(), obtenerImagenCamara()},
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          for (int cont = 0; cont < 1; cont++) cajonImagen(),
        ],
      ),
    );
  }

  // onPressed: obtenerImagenCamara,
  Widget cajonImagen() {
    bool noImage = contenidoWebService[0]['proyectos']
                    [posicionListaProyectosSeleccionado]['datos']
                ['fileFotoPrincipal'] ==
            null ||
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['fileFotoPrincipal'] ==
            "";
    return GestureDetector(
      onTap: () {
        noImage ? seleccionarGaleriaCamara(context) : removerImagen();
      },
      child: Container(
          width: 102.11.sp,
          height: 102.63.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.transparent,
            image: DecorationImage(
                image: noImage
                    ? AssetImage(
                        'assets/img/Desglose/Demas/btn-add.png',
                      )
                    : imageFromBase64String(contenidoWebService[0]['proyectos']
                            [posicionListaProyectosSeleccionado]['datos']
                        ['fileFotoPrincipal']),
                fit: BoxFit.cover),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              noImage
                  ? Text('')
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                      ),
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        FontAwesomeIcons.times,
                        color: Colors.white,
                        size: 20,
                      ))
            ],
          )),
    );
  }
}
