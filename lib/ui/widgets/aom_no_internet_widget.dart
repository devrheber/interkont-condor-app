import 'package:flutter/material.dart';

class AomNoInternetWidget extends StatelessWidget {
  const AomNoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
      backgroundColor: const Color(0xff002F5E),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: const AssetImage("assets/img/Desglose/Demas/bg-nosenal.jpg"),
                fit: BoxFit.cover),
          ),
          padding:
              const EdgeInsets.only(top: 80.0, bottom: 20.0, left: 70.0, right: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: const AssetImage('assets/img/Desglose/Demas/icn-nosenal.png'),
                width: 80.0,
                height: 130,
              ),
              const Text(
                'Verifica tu conexion a Internet e intenta ingresar nuevamente',
                style: const TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 231,
                  height: 53,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff49CC85),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Regresar',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
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
