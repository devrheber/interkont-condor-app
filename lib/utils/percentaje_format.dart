import 'package:intl/intl.dart';

class PercentajeFormat {
  static final NumberFormat _f = NumberFormat.percentPattern("en_US");
  static final NumberFormat _f1 = NumberFormat("#,##0.0", "en_US");
  static final NumberFormat _f2 = NumberFormat("#,##0.00", "en_US");

  static String percentaje(double value, {int precision = 2}) {
    if (precision == 0) {
      return _f.format(value / 100);
    }
    if (precision == 1) {
      return '${_f1.format(value)} %';
    }
    return '${_f2.format(value)} %';
  }
}
