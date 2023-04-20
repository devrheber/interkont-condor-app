import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet._({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: AppRoutes.noInternet),
      builder: (_) => const NoInternet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        back(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/Desglose/Demas/bg-nosenal.jpg"),
                fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.only(
              top: 80.0, bottom: 20.0, left: 70.0, right: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/img/Desglose/Demas/icn-nosenal.png'),
                width: 80.0,
                height: 130,
              ),
              const Text(
                '¡No te preocupes!',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Mantendremos tu avance guardado en tu dispositivo, cuando tengas nuevamente conexión a internet, puedes volver a guardar este reporte de avance',
                style: AppTheme.parrafoBlanco,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () => back(context),
                child: SizedBox(
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
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
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

  void back(BuildContext context) {
    Navigator.of(context).popUntil(
      ModalRoute.withName(AppRoutes.listaProyectos),
    );
  }
}
