import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/logo.dart';
import 'package:appalimentacion/vistas/preload.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Login/background.jpg"),
            fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0, right: 30.0),
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/10,
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 30.0
                        ),
                        child: LogoImg(),
                      ),
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
                                color: AppTheme.septimo,
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
                                color: AppTheme.septimo,
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
                                    // padding: EdgeInsets.only(top:10.0),
                                    child: TextField(
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
                            builder: (context) => Preload()
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
        height: 120,
        child: Column(
          children: <Widget>[
            Image(
              height: 100.0,
              image: AssetImage(
                'assets/img/Desglose/Login/logo-footer.png'
              )
            )
          ],
        )
      ),
    );
  }
}







