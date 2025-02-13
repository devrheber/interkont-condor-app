import 'package:flutter/material.dart';

import '../../../../globales/colores.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/Desglose/Demas/bg-nosenal.jpg"),
                fit: BoxFit.cover),
          ),
          padding:
              EdgeInsets.only(top: 80.0, bottom: 20.0, left: 70.0, right: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/Desglose/Demas/icn-nosenal.png'),
                width: 80.0,
                height: 130,
              ),
              Text(
                'Parece que no tienes señal',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Guarda tu avance, apenas tu móvil se conecte a Internet tu proyecto automáticamente será actualizado',
                style: AppTheme.parrafoBlanco,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 60.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
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
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Guardar',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> noInternetConnection(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: NoInternet(),
      insetPadding: EdgeInsets.zero,
      elevation: 0,
    ),
  );
}
