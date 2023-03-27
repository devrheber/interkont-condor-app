import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 107),
      child: Stack(
        children: <Widget>[
          Container(
            width: 358,
            height: 126,
            margin: const EdgeInsets.only(top: 50.0, right: 28, left: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffC1C8D9).withOpacity(.3),
                  blurRadius: 26,
                  offset: const Offset(3, 4),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 55.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    context.read<AuthenticationProvider>().user?.username ?? '',
                    style: const TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                      color: Color(0xFF566B8C),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 77,
                      width: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: Image.asset('assets/new/home/profile.png',
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
