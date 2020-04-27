import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class MostrarFotoSubida extends StatefulWidget {
  final int numeroFotos;
  
  MostrarFotoSubida({Key key, this.numeroFotos}) : super(key: key);
  @override
  _MostrarFotoSubidaState createState() => _MostrarFotoSubidaState();
}

class _MostrarFotoSubidaState extends State<MostrarFotoSubida> {
  List<File> listaImagenes = [];

  Future obtenerImagenCamara() async {
    listaImagenes.add(await ImagePicker.pickImage(source: ImageSource.camera));
    setState(() {
      listaImagenes = listaImagenes;
    });
  }

  Future obtenerImagenGaleria() async {
    listaImagenes.add(await ImagePicker.pickImage(source: ImageSource.gallery));
    setState(() {
      listaImagenes = listaImagenes;
    });
  }

  void removerImagen(imagen){
    listaImagenes.remove(imagen);
    setState(() {
      listaImagenes = listaImagenes;
    });
  }

  void seleccionarGaleriaCamara(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(
                  Icons.photo
                ),
                title: new Text('Galeria'),
                onTap: () => {
                  Navigator.of(context).pop(),
                  obtenerImagenGaleria()
                }          
              ),
              new ListTile(
                leading: new Icon(
                  FontAwesomeIcons.camera
                ),
                title: new Text('Camara'),
                onTap: () => {
                  Navigator.of(context).pop(),
                  obtenerImagenCamara()
                },          
              ),
            ],
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0),
      child: Wrap(
        children: <Widget>[
          for(int cont = 0; cont < listaImagenes.length; cont++)
            cajonImagen(listaImagenes[cont]),
          if(listaImagenes.length == 0)
          cajonImagen(null),

        ],
      ),
    );
  }
  // onPressed: obtenerImagenCamara,
  Widget cajonImagen(imagenSeleccionada)
  {
    File imagen = null;
    if(imagenSeleccionada != null){
      imagen = imagenSeleccionada;
    }

    return  GestureDetector(
        onTap: (){
          imagen == null
          ?seleccionarGaleriaCamara(context)
          :removerImagen(imagen);
        },
        child: Container(
          height: 90.0,
          width: MediaQuery.of(context).size.width/4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
              image: DecorationImage(
              image: imagen == null
              ? AssetImage(
                'assets/img/Desglose/Demas/btn-add.png',
                
              )
              : FileImage(imagen),
                fit: BoxFit.cover
              ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              imagen == null
              ?Text('')
              :Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(500)
                  ),
                ),
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(2.0),
                child: Icon(
                  FontAwesomeIcons.times,
                  color: Colors.white,
                  size: 20,
                )
              )
              
            ],
          )
        ),
      );
  }
}