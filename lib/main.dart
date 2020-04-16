import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/logo.dart';
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

  void obtenerListaProyectosSeleccionados()
  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => _rootPage
          ),);
      },
    );

    getRootPage().then((Widget page) async{
        setState(() {
          _rootPage = page;
        });
    });
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
