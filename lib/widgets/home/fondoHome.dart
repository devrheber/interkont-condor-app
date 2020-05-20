import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/logout.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FondoHome extends StatefulWidget {

  final Widget contenido;
  final bool bottomNavigationBar;
  final Widget contenidoBottom;
  final bool primeraPagina;

  FondoHome({
    Key key,
    this.contenido,
    this.bottomNavigationBar,
    this.contenidoBottom,
    this.primeraPagina,
  }) : super(
    key: key
  );

  @override
  FondoHomeState createState() => FondoHomeState();
}

class FondoHomeState extends State<FondoHome> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 0.5
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xffFDCF09),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/img/Desglose/Home/img-perfil.png',
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Bienvenido',
                          style: AppTheme.h2,
                        ),
                        Text(
                          contenidoWebService[0]['usuario']['nombreUsu'],
                          style: AppTheme.parrafo,
                        )
                      ],
                    )
                  ],
                )
              ),

              Ink(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.signOutAlt , color: AppTheme.quinceavo,),
                  title: new 
                    Text(
                      'Cerrar Sesión', 
                      style: 
                        TextStyle(
                          color: AppTheme.catorceavo,
                          fontFamily: 'montserrat'
                        ),
                    ),
                  onTap: () {
                    logout();
                    cambiarPagina(context, LoginPage());
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.celeste,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:  Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      AppTheme.primero,
                      AppTheme.segundo,
                    ],
                  ),
                ),
            ),
            widget.contenido,
            widget.primeraPagina != null
            ?Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 30.0,
                  top: 30.0
                ),
                child: IconButton(
                  onPressed: (){
                     _drawerKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,

                  ),
                )
              )
            )
            :Text(
              ''
            )
          ],
        ),
        bottomNavigationBar: 
        widget.bottomNavigationBar == true
        ?widget.contenidoBottom
        :null
      ),
    );
  }
}