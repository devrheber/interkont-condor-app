import 'package:flutter/material.dart';

class LogoImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var assetsImage = new AssetImage('assets/img/Desglose/Login/logo.png');
    var image = new Image(
      image: assetsImage, 
      width: 150.0, 
      height: 130,
    );
    return new Container( 
      child: image,
    );
  }
}