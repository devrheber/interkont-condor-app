import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:appalimentacion/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                        context.read<AuthenticationProvider>().user.username,
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
                Navigator.pop(context);
                final authProvider =
                    Provider.of<AuthenticationProvider>(context, listen: false);
                final result = await authProvider.logout();
                if (result) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage.init()),
                      (Route<dynamic> route) => false);
                } else {
                  Toast.show(
                      'Ocurrió un error al intentar cerrar sessión');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
