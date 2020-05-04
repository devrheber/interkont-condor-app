import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/actualizarProyectos.dart';
import 'package:appalimentacion/globales/funciones/obtenerListaProyectos.dart';
import 'package:appalimentacion/globales/logo.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:appalimentacion/vistas/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
  MaterialApp(
    home: TodoApp(),
    theme: ThemeData(
      fontFamily: 'WorkSans',
      textTheme: AppTheme.textTheme,
    ),
  )
);

class TodoApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp>{

  SharedPreferences prefs;
  void obtenerListaProyectosSeleccionados()
  async{
    prefs = await SharedPreferences.getInstance();
    // obtenerDataGuardada();
    if(prefs.getInt('estadoLogin') == 200){
      await obtenerListaProyectos();
      await actualizarProyectos();
    }
  }

  // void obtenerDataGuardada()
  // async{  //CONTENIDO DE LA WEB SERVICES = LISTA DE PROYECTOS Y DATOS DEL USUARIO LOGEADO
  //   if(prefs.getString('contenidoWebService') == null){
  //     // contenidoWebService = [];
  //   }else{
  //     // contenidoWebService = jsonDecode(prefs.getString('contenidoWebService'));
  //   }
  // }
  
  @override
  void initState(){
    super.initState();
    obtenerListaProyectosSeleccionados();
    
    Future.delayed(
      Duration(seconds: 3),
      () {
        if(prefs.getInt('estadoLogin') == null){
          setState(() {
            _rootPage = LoginPage();
          });
        }else if(prefs.getInt('estadoLogin') == 200){
          setState(() {
            _rootPage = ListaProyectos();
          });
        }else{
          setState(() {
            _rootPage = LoginPage();
          });
        }
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => _rootPage
          ),);
      },
    );
  }
  
  Widget _rootPage = LoginPage();
  
  Future<Widget> getRootPage() async =>
    LoginPage();
     
    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/Desglose/Login/background.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: LogoImg(),
          )
        ),
      );
    }
}
