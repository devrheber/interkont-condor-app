import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/obtenerListaProyectos.dart';
import 'package:appalimentacion/globales/logo.dart';
import 'package:appalimentacion/globales/sized_box.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:appalimentacion/vistas/login/local_widgets/textfield.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  SharedPreferences prefs;
  bool loading = false;

  int estadoLogin;

  @override
  void initState() {
    super.initState();

    obtener();
  }

  void obtener() async {
    prefs = await SharedPreferences.getInstance();
    print('Estado login:');
    print(prefs.getInt('estadoLogin'));
    setState(() {
      usuario.text = 'interkont@2';
      contrasena.text = '45911804';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                          BuildSizedBox(height: 169.0),
                          LogoImg(
                            assetImageRoute: "assets/new/login/logo.png",
                            width: 234,
                            height: 209.95,
                          ),
                          BuildSizedBox(height: 99.05),
                          Container(
                            child: CustomedTextField(
                              controller: usuario,
                              hintText: "Usuario",
                              imageIcon: 'assets/new/login/account_circle.png',
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
                            imageIcon: 'assets/new/login/lock_circle.png',
                          ),
                          BuildSizedBox(height: 12),
                          Container(
                            height: 58.sp,
                            width: 350.sp,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                validarLogin();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Preload(
                                //         txt_usuario: txt_usuario,
                                //         txt_contrasena: txt_contrasena),
                                //   ),
                                // );
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
                                    children: [
                                      ...loadingLogin(loading),
                                      loading
                                          ? Container()
                                          : Text(
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
                          estadoLogin != null && estadoLogin != 200
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
                          SizedBox(
                            height: 43.sp,
                          ),
                          FooterImg(
                            width: 259.57,
                            height: 87,
                          ),
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

  List<Widget> loadingLogin(bool loading) {
    if (!loading) return [];
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

  validarLogin() async {
    setState(() {
      estadoLogin = null;
      loading = true;
    });
    String url = "$urlGlobalApiCondor/login";
    prefs = await SharedPreferences.getInstance();

    var body = {
      "usuario": "${usuario.text}",
      "contrasena": "${contrasena.text}"
    };

    try {
      HttpClient client = new HttpClient(); 
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();
      print('------------');
      print(response);
      print('------------');
      print('------------');
      print(response.statusCode);
      print('------------');
      print('------------');
      print(response.headers);
      print('------------');
      print('------------');
      print(response.headers['authorization'][0]);
      print('------------');
      var respuesta = await respuestaHttp(response.statusCode);

      await prefs.setInt('estadoLogin', response.statusCode);
      if (respuesta == true) {
        contenidoWebService[0]['usuario']['tokenUsu'] =
            response.headers['authorization'][0];
        contenidoWebService[0]['usuario']['nombreUsu'] = "${usuario.text}";
        await obtenerListaProyectos();
        await prefs.setString(
            'contenidoWebService', jsonEncode(contenidoWebService));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaProyectos()),
        );
      } else {
        setState(() {
          loading = false;
        });
      }
      // else {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginPage()),
      //   );
      // }
    } catch (erro) {
      setState(() {
        estadoLogin = 800;
        loading = false;
      });
      print('-------');
      print(erro);

      await prefs.setInt('estadoLogin', 800);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      // );
    }
  }
}
