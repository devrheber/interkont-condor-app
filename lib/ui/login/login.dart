import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../globales/colores.dart';
import '../../globales/logo.dart';
import '../../globales/sized_box.dart';
import '../../routes/app_routes.dart';
import '../../theme/color_theme.dart';
import '../../utils/assets/assets.dart';
import '../authentication/authentication_provider.dart';
import 'local_widgets/textfield.dart';
import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => LoginProvider(
          prefs: context.read(),
          loginRepository: context.read(),
        ),
        child: const LoginPage._(),
      );

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  @override
  void initState() {
    super.initState();

    obtener();
  }

  void obtener() async {
    setState(() {
      usuario.text = 'interkont@2';
      contrasena.text = 'Int4rkont*_22';
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: ColorTheme.backgroundGradient,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const BuildSizedBox(height: 169.0),
                          const LogoImg(
                            assetImageRoute: Assets.assetsNewLoginLogo,
                            width: 234,
                            height: 209.95,
                          ),
                          const BuildSizedBox(height: 99.05),
                          Container(
                            child: CustomedTextField(
                              controller: usuario,
                              hintText: "Usuario",
                              imageIcon: Assets.assetsNewLoginAccountCircle,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (texto) {
                                // usuario = texto;
                              },
                            ),
                          ),
                          CustomedTextField(
                            controller: contrasena,
                            obscureText: true,
                            hintText: "Contraseña",
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (texto) {
                              // contrasena = texto;
                            },
                            imageIcon: Assets.assetsNewLoginLockCircle,
                          ),
                          const BuildSizedBox(height: 12),
                          Container(
                            height: 58.sp,
                            width: 350.sp,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final user = await context
                                      .read<LoginProvider>()
                                      .login(
                                          username: usuario.text,
                                          password: contrasena.text);

                                  if (user != null) {
                                    context
                                        .read<AuthenticationProvider>()
                                        .updateUser(user);
                                    await Navigator.of(context)
                                        .pushReplacementNamed(
                                            AppRoutes.listaProyectos);
                                  }
                                  // validarLogin();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Preload(
                                  //         txt_usuario: txt_usuario,
                                  //         txt_contrasena: txt_contrasena),
                                  //   ),
                                  // );
                                } on SocketException catch (_) {
                                  Toast.show(
                                      'Ocurrió un error intentado conectarse al servidor');
                                } catch (_) {}
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              ),
                              // padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: ColorTheme.buttonGradient,
                                ),
                                child: Container(
                                  // constraints: BoxConstraints(maxWidth: 250.0, minHeight: 20.0),

                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: loginProvider.loading
                                        ? loadingLogin()
                                        : [
                                            Text(
                                              "Ingresar",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            )
                                          ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          loginProvider.estadoLogin != null &&
                                  loginProvider.estadoLogin != 200
                              ? Column(
                                  children: <Widget>[
                                    Container(
                                      height: 53.sp,
                                      child: Text(
                                        '\nLo sentimos\nel usuario o la contraseña es incorrecta',
                                        style: AppTheme.parrafoBlanco,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(height: 53.sp, child: Text('')),
                          SizedBox(height: 43.sp),
                          const FooterImg(width: 259.57, height: 87),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> loadingLogin() {
    return [
      Container(
        height: 15.sp,
        width: 15.sp,
        child: CircularProgressIndicator(
          strokeWidth: 3.sp,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withOpacity(0.5),
          ),
        ),
      ),
      SizedBox(width: 9.sp),
      Text(
        "Ingresando",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
        ),
      ),
    ];
  }
}
