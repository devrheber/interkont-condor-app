import 'package:flutter/material.dart';

Future<dynamic> loadingDialog(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 100.0,
            width: 100.0,
            child: Column(
              children: [
                Spacer(),
                Text('Cargando...'),
                Spacer(),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF735EF0)),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      });
}
