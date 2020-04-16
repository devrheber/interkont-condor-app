import 'dart:io';
import 'package:appalimentacion/globales/colores.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File _image;
  List<File> listaImagenes;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secundario,
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Container(
          child: Row(
            children: <Widget>[
              cajonImagen(),
              cajonImagen(),
              cajonImagen(),
              
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget cajonImagen()
  {
    return Expanded(
      child: Container(
        height: 100.0,
        margin: EdgeInsets.only(top:10.0, left: 5.0, right: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey,
            image: DecorationImage(
            image: _image == null
            ? AssetImage('assets/img/addImage.PNG')
            : FileImage(_image),
              fit: BoxFit.cover
            ),
        ),
        
        
      ),
    );
  }
}

// Container(
//               height: 110.0,
//               width: 50.0,
//               child: Image.file(_image),
//             ),