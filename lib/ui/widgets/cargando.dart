import 'package:appalimentacion/constants/api_routes.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog._({Key? key}) : super(key: key);

  factory LoadingDialog() => _instance;
  const LoadingDialog._internal();
  static const LoadingDialog _instance = LoadingDialog._internal();

  static var _isOpen = false;

  static Future<dynamic> show(BuildContext context) async {
    if (!_isOpen) {
      _isOpen = true;
      return showDialog(
        routeSettings: const RouteSettings(name: ApiRoutes.loadingDialog),
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: LoadingDialog._(),
          );
        },
      );
    }
  }

  static void hide(BuildContext context) {
    if (_isOpen) {
      Navigator.of(context).pop();
      _isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: Column(
        children: const [
          Spacer(),
          Text('Cargando...'),
          Spacer(),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF735EF0)),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
