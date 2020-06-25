import 'dart:convert';
import 'dart:io';
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
  AnimationController _controllerPeque;
  Animation<double> animation;
  double i = 100;

  SharedPreferences prefs;
  validarLogin()
  async{
    String url ="$urlGlobal/cobra-ws-condor/login";
    prefs = await SharedPreferences.getInstance();
    
    var body = {
      'usuario':"${widget.txt_usuario}", 
      'contrasena':"${widget.txt_contrasena}"
    };

    try{
      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url)); 
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();
      print('------------');
      print(response);
      print('------------');
      print('------------');
      print(response.statusCode);
      print('------------');
      print('------------');
      print(response.headers);
      print('------------');
      print('------------');
      print(response.headers['authorization'][0]);
      print('------------');
      var respuesta = await respuestaHttp(response.statusCode);

      await prefs.setInt('estadoLogin', response.statusCode);
      if(respuesta == true ){
        contenidoWebService[0]['usuario']['tokenUsu'] = response.headers['authorization'][0];
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
    }catch(erro){
      print('-------');
      print(erro);
      await prefs.setInt('estadoLogin', 800);
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
    animacion();
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        validarLogin();
      },
    );
  }

  animacion()
  {
    print(_controller);
    if(_controller != null)
    {
      setState(() {
        _controller = null;
      });
    }
    _controller = AnimationController(duration:const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0, end: 500).animate(_controller)
    ..addListener((){
      if(double.parse('${animation.value.toStringAsFixed(0)}') % 50 == 0){
        if(i == 200){
          setState(() {
            i = 100;
          });
        }else{
          setState(() {
            i = 200;
          });
        }
      }
    });
    _controller.forward();
  }

  animacionPeque()
  {
    animation =Tween<double>(begin: 0, end: 500).animate(_controller)
    ..addListener((){
      setState((){
        i = double.parse('${animation.value.toStringAsFixed(0)}');
      });
    });
    _controller.forward();
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Preloader/bg-preloader.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: (){
                  print('clickaso');
                  // if(i == 100){
                  //   setState(() {
                  //     i = 150;
                  //   });
                  // }else{
                  //   setState(() {
                  //     i = 100;
                  //   });
                  // }
                  
                  animacion();
                  // animacionPeque();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: i,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/img/Desglose/Preloader/logo.png',
                      ),
                    ),
                  ),
                ),
              )
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
