import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/lista_proyectos_page/home.dart';
import 'package:flutter/material.dart';

class Felicitaciones extends StatelessWidget {
  const Felicitaciones({
    Key? key,
    required this.projectCode,
  }) : super(key: key);

  final int projectCode;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context)
            .pushAndRemoveUntil(ListaProyectosPage.route(), (route) => false);

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  const BoxDecoration(gradient: ColorTheme.congratsGradient),
            ),
            Image.asset(
              'assets/new/home/congrats.gif',
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                const Image(
                  image: AssetImage('assets/new/home/congrats_check.png'),
                  width: 44,
                  height: 44,
                ),
                // Text(
                //   '¡Felicitaciones!',
                //   style: TextStyle(
                //     fontFamily: 'montserrat',
                //     fontWeight: FontWeight.bold,
                //     fontSize: 25,
                //     color: Colors.white,
                //   ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset('assets/new/home/success.png', width: 288),

                const SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).pushAndRemoveUntil(
                      ListaProyectosPage.route(),
                      (route) => false,
                    );
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
                        children: const <Widget>[
                          Text(
                            'Volver al inicio',
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
