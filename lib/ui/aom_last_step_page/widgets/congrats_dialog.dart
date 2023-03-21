import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';

class CongratsDialog extends StatelessWidget {
  const CongratsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context)
            .pushNamed(AppRoutes.listaProyectosAOM);

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(gradient: ColorTheme.congratsGradient),
            ),
            Image.asset(
              'assets/new/home/congrats.gif',
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  const Image(
                    image: AssetImage('assets/new/home/congrats_check.png'),
                    width: 44,
                    height: 44,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'El reporte de actualización\nAOM fue registrado\n correctamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Image.asset('assets/new/home/success.png', width: 288),

                  const SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                      onTap: () async {
                        await Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.listaProyectosAOM);
                      },
                      child: Container(
                        height: 53,
                        margin: const EdgeInsets.symmetric(horizontal: 91),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff49CC85),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Regresar',
                                style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
