import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MostrarFotoSubida extends StatefulWidget {
  final int numeroFotos;

  MostrarFotoSubida({Key key, this.numeroFotos}) : super(key: key);
  @override
  _MostrarFotoSubidaState createState() => _MostrarFotoSubidaState();
}

class _MostrarFotoSubidaState extends State<MostrarFotoSubida> {
  @override
  void initState() {}

  List<File> listaImagenes = [];
  String base64Image;
  Future obtenerImagenCamara() async {
    final picked = await ImagePicker().getImage(source: ImageSource.camera);
    listaImagenes.add(File(picked.path));
    setState(() {
      listaImagenes = listaImagenes;
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
              ['datos']['fileFotoPrincipal'] =
          base64Encode(listaImagenes[0].readAsBytesSync());
    });
  }

  Future obtenerImagenGaleria() async {
    final picked = await ImagePicker().getImage(source: ImageSource.gallery);
    listaImagenes.add(File(picked.path));
    setState(() {
      listaImagenes = listaImagenes;
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
              ['datos']['fileFotoPrincipal'] =
          base64Encode(listaImagenes[0].readAsBytesSync());
    });
  }

  void removerImagen(imagen) {
    listaImagenes.remove(imagen);
    setState(() {
      listaImagenes = listaImagenes;
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
          for (int cont = 0; cont < listaImagenes.length; cont++)
            cajonImagen(listaImagenes[cont]),
          if (listaImagenes.length == 0) cajonImagen(null),
        ],
      ),
    );
  }

  // onPressed: obtenerImagenCamara,
  Widget cajonImagen(imagenSeleccionada) {
    File imagen = null;
    if (imagenSeleccionada != null) {
      imagen = imagenSeleccionada;
    }

    return GestureDetector(
      onTap: () {
        imagen == null
            ? seleccionarGaleriaCamara(context)
            : removerImagen(imagen);
      },
      child: Container(
          width: 102.11.sp,
          height: 102.63.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.transparent,
            image: DecorationImage(
                image: imagen == null
                    ? AssetImage(
                        'assets/img/Desglose/Demas/btn-add.png',
                      )
                    : FileImage(imagen),
                fit: BoxFit.cover),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              imagen == null
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
