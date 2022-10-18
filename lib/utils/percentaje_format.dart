import 'package:intl/intl.dart';

class PercentajeFormat {
  static NumberFormat _f = new NumberFormat("#,##0.0", "es_AR");
  static NumberFormat _f2 = new NumberFormat("#,##0.00", "es_AR");

  static String percentaje(double value) {
    return '${_f2.format(value)} %';
  }
}
