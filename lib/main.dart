import 'package:appalimentacion/globales/colores.dart';
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
    await prefs.setString('listProyectosSeleccionados', '[]');
    await prefs.setString('estadoInformeProyecto', 'informeNoAprobado');
  }
  
  @override
  void initState(){
    super.initState();
    obtenerListaProyectosSeleccionados();
    Future.delayed(
      Duration(seconds: 3),
      () {
        print('main estado login:');
        print(prefs.getInt('estadoLogin'));
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

    // getRootPage().then((Widget page) async{
    //   if(prefs.getInt('estadoLogin') == null){
    //     setState(() {
    //       _rootPage = page;
    //     });
    //   }else if(prefs.getInt('estadoLogin') == 200){
    //     setState(() {
    //       _rootPage = ListaProyectos();
    //     });
    //   }else{
    //     setState(() {
    //       _rootPage = page;
    //     });
    //   }
      
    // });
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
