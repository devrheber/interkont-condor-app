import 'package:flutter/material.dart';

cambiarPagina(context, Widget nuevaPagina) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nuevaPagina,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false);
}

// TRADICIONAL --
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => Proyecto()
//   )
// );
