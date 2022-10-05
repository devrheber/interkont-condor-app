import 'package:appalimentacion/vistas/listaProyectos/vista_lista_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../globales/funciones/logout.dart';
import '../../globales/transicion.dart';
import '../../theme/color_theme.dart';
import '../../vistas/login/login.dart';

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
  }) : super(key: key);

  @override
  FondoHomeState createState() => FondoHomeState();
}

class FondoHomeState extends State<FondoHome> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VistaListaProvider>(context, listen: false);

    return Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.1))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 20.sp),
                        height: 65.sp,
                        width: 65.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 5.sp),
                        ),
                        child: Image.asset('assets/new/home/profile.png',
                            fit: BoxFit.fill),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Bienvenido',
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                           // contenidoWebService[0]['usuario']['nombreUsu'],
                          //   // 'Usuario Admin',
                          provider.userDataSession['username'],
                            style: TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 15.sp,
                              color: Color(0xFF566B8C),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Ink(
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: ColorTheme.primary,
                  ),
                  title: new Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp,
                      color: Color(0xFF566B8C),
                    ),
                  ),
                  onTap: () async { 
                    //cerrar drawerkey
                    Navigator.pop(context);
                    await logout();
                    cambiarPagina(context, LoginPage());
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xffF6F4FC),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 214.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp)),
                gradient: ColorTheme.backgroundGradient,
              ),
            ),
            widget.contenido,
            widget.primeraPagina != null
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            right: 14.sp, left: 14.sp, top: 50.h),
                        child: IconButton(
                          onPressed: () {
                            _drawerKey.currentState.openDrawer();
                          },
                          icon: Icon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        )))
                : Text('')
          ],
        ),
        bottomNavigationBar:
            widget.bottomNavigationBar == true ? widget.contenidoBottom : null);
  }
}
