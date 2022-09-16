import 'package:flutter/material.dart';

// void cambiarPagina(context, Widget page) {
//   Navigator.of(context).pushAndRemoveUntil( 
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => page,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(0.0, 1.0);
//           const end = Offset.zero;
//           const curve = Curves.fastLinearToSlowEaseIn;

//           var tween = 
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//           return SlideTransition(
//             position: animation.drive(tween),
//             child: child,
//           );
//         },
//       ),
//       (Route<dynamic> route) => false);
// }


///no animation transition

void cambiarPagina(context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false);
}
