import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../routes/app_routes.dart';
import '../../theme/color_theme.dart';
import '../authentication/authentication_provider.dart';
import '../login/login.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.1))),
            child: Row(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
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
                        color: const Color(0xFF000000),
                      ),
                    ),
                    Text(
                      context.read<AuthenticationProvider>().user?.username ??
                          'usuario desconocido',
                      style: TextStyle(
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w200,
                        fontSize: 15.sp,
                        color: const Color(0xFF566B8C),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _SideMenuOptions(
            icon: FontAwesomeIcons.chartColumn,
            text: 'Reporte de Proyectos',
            onTap: () => _toReportPage(context),
          ),
          // TODO mostrar solo para app  Avanzame
          // _SideMenuOptions(
          //   icon: FontAwesomeIcons.box,
          //   text: 'Reporte de Activos AOM',
          //   onTap: () => _toAOMPage(context),
          // ),
          _SideMenuOptions(
            icon: FontAwesomeIcons.rightFromBracket,
            text: 'Cerrar Sesión',
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  String? getCurrentPageName(BuildContext context) {
    String? name = ModalRoute.of(context)?.settings.name;
    return name;
  }

  Future<void> _logout(BuildContext context) async {
    Navigator.pop(context);
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final result = await authProvider.logout();
    if (result) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage.init()),
          (Route<dynamic> route) => false);
    } else {
      Toast.show('Ocurrió un error al intentar cerrar sessión');
    }
  }

  // Future<void> _toAOMPage(BuildContext context) async {
  //   Navigator.pop(context);
  //   if (getCurrentPageName(context) != AppRoutes.listaProyectosAOM) {
  //     await Navigator.of(context).pushNamed(AppRoutes.listaProyectosAOM);
  //   }
  // }

  Future<void> _toReportPage(BuildContext context) async {
    Navigator.pop(context);
    if (getCurrentPageName(context) != AppRoutes.listaProyectos) {
      await Navigator.of(context)
          .pushReplacementNamed(AppRoutes.listaProyectos);
    }
    if (getCurrentPageName(context) == AppRoutes.listaProyectosAOM) {
      Navigator.pop(context);
    }
  }
}

class _SideMenuOptions extends StatelessWidget {
  const _SideMenuOptions({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 5,
      leading: FaIcon(
        icon,
        color: ColorTheme.primary,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "montserrat",
          fontWeight: FontWeight.w400,
          fontSize: 17.sp,
          color: const Color(0xFF566B8C),
        ),
      ),
      onTap: onTap,
    );
  }
}
