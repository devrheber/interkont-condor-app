import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required Widget child,
  }) async {
    if (Platform.isAndroid) {
      return showDialog<bool>(context: context, builder: (_) => child);
    }
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(context: context, builder: (_) => child);
    }

    // TODO Manage showdialog to other platforms
    return false;
  }
}
