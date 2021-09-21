import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MostrarFotosSubidas extends StatefulWidget {
  final int numeroFotos;

  MostrarFotosSubidas({Key key, this.numeroFotos}) : super(key: key);
  @override
  _MostrarFotosSubidasState createState() => _MostrarFotosSubidasState();
}

class _MostrarFotosSubidasState extends State<MostrarFotosSubidas> {
  List listaImagenes = [];

  Future obtenerImagenCamara() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);

    listaImagenes
        .add({'image': File(picked.path), 'posicion': listaImagenes.length});

    setState(() {
      listaImagenes = listaImagenes;
      var listaArmada = {
        "image": base64Encode(
            listaImagenes[listaImagenes.length - 1]['image'].readAsBytesSync()),
        "nombre": "imagenesComplementarias",
        "tipo": "jpeg",
        "posicion": listaImagenes.length - 1
      };
      if (contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'] ==
          null) {
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['filesFotosComplementarias'] = [listaArmada];
      } else {
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['filesFotosComplementarias']
            .add(listaArmada);
      }
    });
  }

  Future obtenerImagenGaleria() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    listaImagenes
        .add({'image': File(picked.path), 'posicion': listaImagenes.length});
    setState(() {
      listaImagenes = listaImagenes;
      var listaArmada = {
        "image": base64Encode(
            listaImagenes[listaImagenes.length - 1]['image'].readAsBytesSync()),
        "nombre": "imagenesComplementarias",
        "tipo": "jpeg",
        "posicion": listaImagenes.length - 1
      };
      if (contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'] ==
          null) {
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
            ['datos']['filesFotosComplementarias'] = [listaArmada];
      } else {
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['filesFotosComplementarias']
            .add(listaArmada);
      }
    });
  }

  void removerImagen(posicionActual, imagen, posicion) {
    print(posicionActual);
    List listaImagenesMigrarContenidoWebService = [];
    for (int cont = 0;
        cont <
            contenidoWebService[0]['proyectos']
                        [posicionListaProyectosSeleccionado]['datos']
                    ['filesFotosComplementarias']
                .length;
        cont++) {
      if (contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'][cont]['posicion'] !=
          posicion) {
        listaImagenesMigrarContenidoWebService.add({
          "image": contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'][cont]['image'],
          "nombre": contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'][cont]['nombre'],
          "tipo": contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'][cont]['tipo'],
          "posicion": contenidoWebService[0]['proyectos']
                  [posicionListaProyectosSeleccionado]['datos']
              ['filesFotosComplementarias'][cont]['posicion']
        });
      }
    }

    List listaImagenesMigrar = [];
    for (int cont = 0; cont < listaImagenes.length; cont++) {
      if (listaImagenes[posicionActual]['posicion'] !=
          listaImagenes[cont]['posicion']) {
        listaImagenesMigrar.add({
          'image': listaImagenes[cont]['image'],
          'posicion': listaImagenes[cont]['posicion']
        });
      }
    }

    setState(() {
      listaImagenes = listaImagenesMigrar;
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
              ['datos']['filesFotosComplementarias'] =
          listaImagenesMigrarContenidoWebService;
    });
  }

  void seleccionarGaleriaCamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Galeria'),
                    onTap: () =>
                        {Navigator.of(context).pop(), obtenerImagenGaleria()}),
                new ListTile(
                  leading: new Icon(FontAwesomeIcons.camera),
                  title: new Text('Camara'),
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
        alignment: WrapAlignment.start,
        children: <Widget>[
          for (int cont = 0; cont < listaImagenes.length; cont++)
            cajonImagen(
              cont,
              listaImagenes[cont]['image'],
              listaImagenes[cont]['posicion'],
            ),
          cajonImagen(0, null, 0),
          if (listaImagenes.length % 3 != 0) cajonImagen(0, null, 0),
          if (listaImagenes.length == 0) cajonImagen(0, null, 0)
        ],
      ),
    );
  }

  // onPressed: obtenerImagenCamara,
  Widget cajonImagen(posicionActual, imagenSeleccionada, posicion) {
    File imagen = null;
    if (imagenSeleccionada != null) {
      imagen = imagenSeleccionada;
    }
    return GestureDetector(
      onTap: () {
        imagen == null
            ? seleccionarGaleriaCamara(context)
            : removerImagen(posicionActual, imagen, posicion);
      },
      child: Container(
        width: 102.11.sp,
        height: 102.63.sp,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(right: 22.89.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(imagen == null ? 0 : 15.0.sp),
        ),
        child: Stack(
          children: [
            imagen == null
                ? Image.asset(
                    'assets/img/Desglose/Demas/btn-add.png',
                  )
                : Image.file(
                    imagen,
                    width: 102.11.sp,
                    height: 102.63.sp,
                    fit: BoxFit.fill,
                  ),
            imagen == null
                ? Container()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                      ),
                      margin: EdgeInsets.all(8.86.sp),
                      child: Icon(
                        FontAwesomeIcons.times,
                        color: Colors.white,
                        size: 33.4.sp,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
