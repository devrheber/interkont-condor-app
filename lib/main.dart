import 'dart:io';

import 'package:appalimentacion/globales/ssl_solution.dart';
import 'package:appalimentacion/translation/localizations_delegates.dart';
import 'package:appalimentacion/translation/supported_locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globales/colores.dart';
import 'globales/funciones/actualizarProyectos.dart';
import 'globales/funciones/obtenerListaProyectos.dart';
import 'globales/logo.dart';
import 'theme/color_theme.dart';
import 'vistas/listaProyectos/home.dart';
import 'vistas/login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
 
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoApp(),
          localizationsDelegates: LocalizationDelegates.delegates,
          supportedLocales: SupportedLocales.locale,
          theme: ThemeData(
            fontFamily: 'WorkSans',
            textTheme: AppTheme.textTheme,
          ),
        );
      },
    ),
  );
}

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  SharedPreferences prefs;
  void obtenerListaProyectosSeleccionados() async {
    prefs = await SharedPreferences.getInstance();
    // obtenerDataGuardada();
    if (prefs.getInt('estadoLogin') == 200) {
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
  void initState() {
    super.initState();
    obtenerListaProyectosSeleccionados();

    Future.delayed(
      Duration(seconds: 4),
      () {
        if (prefs.getInt('estadoLogin') == null) {
          setState(() {
            _rootPage = LoginPage();
          });
        } else if (prefs.getInt('estadoLogin') == 200) {
          setState(() {
            _rootPage = ListaProyectos();
          });
        } else {
          setState(() {
            _rootPage = LoginPage();
          });
        }
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  _rootPage,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
            (Route<dynamic> route) => false);
      },
    );
  }

  Widget _rootPage = LoginPage();

  Future<Widget> getRootPage() async => LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: ColorTheme.backgroundGradient,
          ),
          child: Center(
            child: LogoImg(),
          )),
    );
  }
}
