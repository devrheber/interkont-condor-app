import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CurrencyFormatterHelper {
  static String format(double? newValue) {
    if (newValue == null) return '';
    if (kDebugMode) {
      print('set format to: $newValue');
    }
    num _newNum = 0;
    String _newString = '';
    final NumberFormat format = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$ ',
    );

    _newNum = newValue;

    _newString = format.format(_newNum).trim();
    return _newString;
  }
}
