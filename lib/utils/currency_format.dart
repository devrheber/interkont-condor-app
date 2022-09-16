import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController({
    String initialValue = '',
  }) {
    addListener(() {
      updateValue(numberValue);
      afterChange(text, numberValue);
    });

    updateValue(initialValue);
  }

  Function afterChange = (String maskedValue, String rawValue) {};

  String _lastValue = '';

  void updateValue(String value) {
    String valueToUse = value;

    if (value.length > 15) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    final String masked = _applyMask(valueToUse);

    if (masked != text) {
      text = masked;

      final int cursorPosition = super.text.length;
      selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition),
      );
    }
  }

  String get numberValue {
    final List<String> parts = _getOnlyNumbers(text).split('').toList();

    return parts.join();
  }

  String _getOnlyNumbers(String text) {
    final String cleanedText = text;

    final RegExp onlyNumbersRegex = RegExp(r'[^\d]');
    return cleanedText.replaceAll(onlyNumbersRegex, '');
  }

  String _formatNumber(String s) {
    const String _locale = 'es_CO';
    return NumberFormat.decimalPattern(_locale).format(int.parse(s));
  }

  String _applyMask(String value) {
    if (value == '') return value;

    return _formatNumber(value.replaceAll(',', ''));
  }
}
