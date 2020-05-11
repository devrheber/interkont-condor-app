import 'dart:convert';
import 'package:appalimentacion/globales/funciones/obtenerListaProyectos.dart';
import 'package:appalimentacion/vistas/login.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:http/http.dart' as http;
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preload extends StatefulWidget{

  final String txt_usuario;
  final String txt_contrasena;

  Preload({Key key, this.txt_contrasena, this.txt_usuario}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PreloadState();

}

class _PreloadState extends State<Preload> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  Animation<double> animation;
  String i = '0';

  SharedPreferences prefs;
  validarLogin()
  async{
    String url ="$urlGlobal/cobra-ws-condor/login";
    prefs = await SharedPreferences.getInstance();
    
    var body = {
      'usuario':"${widget.txt_usuario}", 
      'contrasena':"${widget.txt_contrasena}"
    };

    var response = await http.post(
      url, 
      body: jsonEncode(body)
    );

    var respuesta = await respuestaHttp(response.statusCode);
    await prefs.setInt('estadoLogin', response.statusCode);

    if(respuesta == true ){
      contenidoWebService[0]['usuario']['tokenUsu'] = response.headers['authorization'];
      contenidoWebService[0]['usuario']['nombreUsu'] = "${widget.txt_usuario}";
      await obtenerListaProyectos();
      await prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ListaProyectos()
        ),
      );
    }else{
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        ),
      );
    }
  }
  
  @override
  void initState(){
    super.initState();
    
    _controller = AnimationController(duration:const Duration(seconds: 3), vsync: this);
    animation =Tween<double>(begin: 1600, end: 0).animate(_controller)
    ..addListener((){
      setState((){
        i = animation.value.toStringAsFixed(0);
      });
    });
    _controller.forward();

    

    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        validarLogin();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Preloader/bg-preloader.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img/Desglose/Preloader/logo.png',
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              width: MediaQuery.of(context).size.width/2,
              // height: 100.0,
              top: MediaQuery.of(context).size.height-150.0,
              right: MediaQuery.of(context).size.width/4.1,
              child: Container(
                child: Image(
                  image: AssetImage(
                    'assets/img/Desglose/Login/logo-footer.png',
                  )
                )
              )
            )
          ],
        )
      ),
      // bottomNavigationBar: Container(
      //   color: AppTheme.primero,
      //   height: 100,
      //   child: Column(
      //     children: <Widget>[
      //       Image(
      //         height: 100.0,
      //         image: AssetImage(
      //           'assets/img/Desglose/Login/logo-footer.png'
      //         )
      //       )
      //     ],
      //   )
      // ),
    );
    
  }
  
  Widget aro(Widget contenido, int rgb)
  {
    return Container(
      child: contenido
    );
  }
}
