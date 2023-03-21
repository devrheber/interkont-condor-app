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
          ),
        );
      });
}

class LoadingDialog {
  factory LoadingDialog() => _instance;
  LoadingDialog._internal();
  static final LoadingDialog _instance = LoadingDialog._internal();

  static void show(BuildContext context, {Key? key}) {
    _isLoading = true;
    showDialog(
            context: context,
            useRootNavigator: false,
            barrierDismissible: false,
            builder: (_) => const LoadingDialogWidget())
        .then((_) => FocusScope.of(context).requestFocus());
  }

  static void hide(BuildContext context) {
    if (!_isLoading) return;
    _isLoading = false;
    Navigator.pop(context);
  }

  static bool _isLoading = false;
}

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Column(
          children: [
            const Spacer(),
            const Text('Cargando...'),
            const Spacer(),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF735EF0)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
