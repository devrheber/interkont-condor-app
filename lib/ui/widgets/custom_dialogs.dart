import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title = 'Confirmación',
    required this.description,
    this.cancelButtonText = 'Cancelar',
    this.continueButtonText = 'Continuar',
    this.cancelButton,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget? cancelButton;
  final String cancelButtonText;
  final String continueButtonText;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: "montserrat",
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: Color(0xff505050),
    );

    Widget defaultTitle = Text(
      title,
      style: style.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
    );

    Widget defaultContent = Text(
      description,
      style: style,
    );

    Widget defaultCancelButton = TextButton(
      child: Text(cancelButtonText,
          style: TextStyle(
            fontFamily: "montserrat",
            fontWeight: FontWeight.w400,
          )),
      onPressed: () => Navigator.pop(context, false),
    );

    Widget defaultContinueButton = TextButton(
      child: Text(continueButtonText,
          style: TextStyle(
            fontFamily: "montserrat",
            fontWeight: FontWeight.w400,
          )),
      onPressed: () => Navigator.pop(context, true),
    );

    if (Platform.isAndroid) {
      return AlertDialog(
        title: defaultTitle,
        content: defaultContent,
        actions: [
          cancelButton ?? defaultCancelButton,
          defaultContinueButton,
        ],
      );
    }
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: defaultTitle,
        content: defaultContent,
        actions: [
          cancelButton ?? defaultCancelButton,
          defaultContinueButton,
        ],
      );
    }

    // TODO
    return SizedBox.shrink();
  }
}
