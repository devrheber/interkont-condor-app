import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/logo.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/preload.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  String txt_usuario    = '';
  String txt_contrasena = '';
  SharedPreferences prefs;

  int estadoLogin = null;

  @override
  void initState() {
    super.initState();
    obtener();
  }

  void obtener()
  async{
    prefs = await SharedPreferences.getInstance();
    print('Estado login:');
    print(prefs.getInt('estadoLogin'));
    setState(() {
      estadoLogin = prefs.getInt('estadoLogin');
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 120.0
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Login/background.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      LogoImg(),
                      Container(
                        width: MediaQuery.of(context).size.width-60.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              margin: EdgeInsets.only(top:10.0),
                              padding: EdgeInsets.only(left:15.0, right: 15),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(1, 1, 1, 0.1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Image(
                                      image: AssetImage('assets/img/Desglose/Login/icn-imput-user.png'),
                                      width: 17.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      onChanged: (texto){
                                        setState(() {
                                          txt_usuario = texto;
                                        });
                                      },
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Usuario",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.white
                                        )
                                      )
                                    )
                                  ),
                                  
                                ],
                              )
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              margin: EdgeInsets.only(top:10.0),
                              padding: EdgeInsets.only(left:15.0, right: 15),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(1, 1, 1, 0.1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Image(
                                      width: 17.0,
                                      image: AssetImage('assets/img/Desglose/Login/icn-imput-pass.png')
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      onChanged: (texto){
                                        setState(() {
                                          txt_contrasena = texto;
                                        });
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Contraseña",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.white
                                        )
                                      )
                                    )
                                  ),
                                  
                                ],
                              )
                            ),
                          ],
                        )
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Preload(
                              // txt_usuario:'interkont@2',
                              // txt_contrasena:'45911804'
                              txt_usuario:txt_usuario,
                              txt_contrasena:txt_contrasena
                            )
                          ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-60.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only( 
                                topLeft:     Radius.circular(15.0),
                                topRight:    Radius.circular(15.0),
                                bottomLeft:  Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppTheme.onceavo,
                                  AppTheme.onceavo,
                                  AppTheme.onceavo,
                                ],
                              ),
                              border: Border(
                                top: BorderSide(width: 1.0, color: AppTheme.onceavo),
                                left: BorderSide(width: 1.0, color: AppTheme.onceavo),
                                right: BorderSide(width: 1.0, color: AppTheme.onceavo),
                                bottom: BorderSide(width: 1.0, color: AppTheme.onceavo),
                              ),
                            ),
                            padding: EdgeInsets.only(left:20.0, right: 20.0, top: 15.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'LOG IN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          ),
                        )
                      ),
                      SizedBox(
                        height: 5.0,
                      ),


                      estadoLogin != null && estadoLogin != 200
                      ?Column(
                        children: <Widget>[
                          Text(
                            'Lo sentimos',
                            style: AppTheme.parrafoBlanco,
                          ),
                          Text(
                            'el usuario o la contraseña es incorrecta',
                            style: AppTheme.parrafoBlanco,
                          ),
                        ],
                      )
                      :Text(''),

                      SizedBox(
                        height: 15.0,
                      ),

                      Container(
                        child: Image(
                          height: 70.0,
                          image: AssetImage(
                            'assets/img/Desglose/Login/logo-footer.png'
                          )
                        )
                      )
                    ],
                  )
                ],
              ),
            ),            
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppTheme.primero,
        height: 38.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '2020 Powered by',
                  style: AppTheme.parrafoBlanco
                ),
                Image(
                  image: AssetImage(
                    'assets/img/Desglose/Preloader/logo-cliente-footer.png',
                  ),
                  width: 70.0,
                )
              ],
            ),
            Text(
              'Versión $numeroVersion',
              style: AppTheme.parrafoBlanco
            ),
          ],
        )
      ),
    );
  }
}







