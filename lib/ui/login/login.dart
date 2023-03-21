import 'package:appalimentacion/constants/constants.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/logo.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/ui/lista_proyectos_page/home.dart';
import 'package:appalimentacion/utils/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toast/toast.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static Widget init() => BlocProvider(
        create: (context) => LoginBloc(
          userPreferences: context.read(),
          loginRepository: context.read(),
        ),
        child: const LoginPage._(),
      );

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: AppRoutes.login),
      builder: (_) => LoginPage.init(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return const LoginView();
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  FocusNode focusUsuario = FocusNode();
  FocusNode focusContrasena = FocusNode();

  @override
  void dispose() {
    usuario.dispose();
    contrasena.dispose();
    focusUsuario.dispose();
    focusContrasena.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  void loadCredentials() async {
    // txt_usuario:'interkont@2',
    // txt_contrasena:'45911804'
    usuario.text = 'interkont@2';
    contrasena.text = 'Int4rkont*_22';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: ((previous, current) =>
          previous.status != current.status && !current.isLoading),
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushAndRemoveUntil(
              context, ListaProyectosPage.route(), (route) => false);
        }
        if (state.isError && state.message.isNotEmpty) {
          SnackBar snackBar = SnackBar(
            content: Text(state.message),
            backgroundColor: AppTheme.treceavo,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.isLoading ? 1 : 0,
            children: [
              Scaffold(
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    Assets.assetsImgDesgloseLoginBackground),
                                fit: BoxFit.cover),
                          ),
                          child: SizedBox(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 120.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          const Hero(
                                              tag: 'loguito',
                                              child: LogoImg()),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60.0,
                                            child: Column(
                                              children: <Widget>[
                                                CustomTextField(
                                                  hintText: 'Usuario',
                                                  assetsName:
                                                      'assets/Siente/user_icon.png',
                                                  controller: usuario,
                                                  focusNode: focusUsuario,
                                                ),
                                                CustomTextField(
                                                  hintText: 'Contraseña',
                                                  obscureText: true,
                                                  assetsName:
                                                      'assets/Siente/password_icon.png',
                                                  controller: contrasena,
                                                  focusNode: focusContrasena,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          GestureDetector(
                                            onTap: state.isLoading
                                                ? null
                                                : () {
                                                    /// Field Validation
                                                    if (usuario.text.isEmpty ||
                                                        contrasena
                                                            .text.isEmpty) {
                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            'Debe ingresar usuario y contraseña'),
                                                        backgroundColor:
                                                            AppTheme.treceavo,
                                                      );
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);

                                                      return;
                                                    }

                                                    final loginBloc =
                                                        BlocProvider.of<
                                                            LoginBloc>(context);
                                                    loginBloc.add(
                                                      LoginWithCredentialsPressed(
                                                        username: usuario.text,
                                                        password:
                                                            contrasena.text,
                                                      ),
                                                    );
                                                  },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60.0,
                                              child: Container(
                                                  height: 58.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: <Color>[
                                                        AppTheme.onceavo,
                                                        AppTheme.onceavo2,
                                                      ],
                                                    ),
                                                  ),
                                                  child: const Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Ingresar',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          const Image(
                                              height: 70.0,
                                              image: AssetImage(Assets
                                                  .assetsImgDesgloseLoginLogoFotter))
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  color: AppTheme.primero,
                  height: 48,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('2020 Powered by ',
                              style: AppTheme.parrafoBlanco),
                          Text('interkont.co',
                              style: AppTheme.parrafoBlanco
                                  .copyWith(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Text('Versión $versionNumber',
                          style: AppTheme.parrafoBlanco),
                    ],
                  ),
                ),
              ),
              const Preload()
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.assetsName,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
  }) : super(key: key);

  final String hintText;
  final String assetsName;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 58.0,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image(
                image: AssetImage(assetsName),
                width: 17.0,
              ),
            ),
            Expanded(
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Preload extends StatelessWidget {
  const Preload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImgDesglosePreloaderBgPreloader),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
