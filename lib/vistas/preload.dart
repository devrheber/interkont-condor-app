import 'dart:math';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';

class Preload extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PreloadState();

}

class _PreloadState extends State<Preload> with SingleTickerProviderStateMixin {
// class _PreloadState extends State<Preload>{
  
  AnimationController _controller;

  // AnimationController _controllerContador;
  Animation<double> animation;
  String i = '0';

  @override
  void initState(){
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 4000),
    //   vsync: this,
    // );

    _controller = AnimationController(duration:const Duration(seconds: 5), vsync: this);
    animation =Tween<double>(begin: 1600, end: 0).animate(_controller)
    ..addListener((){
      setState((){
        i = animation.value.toStringAsFixed(0);
      });
    });
    _controller.forward();

    super.initState();
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => ListaProyectos()
          ),);
      },
    );
    // super.initState();
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  Future<Widget> getRootPage() async =>
  ListaProyectos();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Preloader/background.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:60.0),
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),                
                child: aro(
                  aro(
                    aro(
                      Container(
                        height: MediaQuery.of(context).size.height/1.8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(38, 38, 38, 0.1),
                          border: Border(
                            top: BorderSide(
                              width: 40.0, 
                              color: Colors.transparent
                            ),
                            left: BorderSide(
                              width: 40.0, 
                              color: Colors.transparent
                            ),
                            right: BorderSide(
                              width: 40.0, 
                              color: Colors.transparent
                            ),
                            bottom: BorderSide(
                              width: 40.0, 
                              color: Colors.transparent
                            ),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/img/Desglose/Preloader/logo.png'),
                          ),
                        ),
                      ),
                      int.parse(i)
                    ),
                    int.parse(i)
                  ),
                  int.parse(i)
                )
              )
              

            ],
          )
        )
      ),
      bottomNavigationBar: Container(
        color: AppTheme.primero,
        height: 100,
        child: Column(
          children: <Widget>[
            Image(
              height: 100.0,
              image: AssetImage(
                'assets/img/Desglose/Login/logo-footer.png'
              )
            )
          ],
        )
      ),
    );
    
  }
  
  Widget aro(Widget contenido, int rgb)
  {
    return Container(
      height: MediaQuery.of(context).size.height/1.8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(rgb, rgb, rgb, 2.1),
        border: Border(
          top: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          left: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          right: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          bottom: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
        ),
      ),
      child: contenido
    );
  }
}
