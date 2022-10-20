import 'package:appalimentacion/globales/funciones/cambiarFormatoFecha.dart';
import 'package:date_format/date_format.dart';

class ProjectHelpers {
  static String setUltimaFechaSincro() {
    // TODO
    final ultimaSincro = 1;

    var fechaActual = DateTime.now();
    var formats = [M, " ", d, " ", yyyy, " ", H, ':', nn];
    final value = '${cambiarFormatoFecha(formatDate(fechaActual, formats))}';

    return value;
  }

  static String getlastSyncDateFormatted(DateTime dateTime) {
    var fechaActual = dateTime;
    var formats = [M, " ", d, " ", yyyy, " ", H, ':', nn];
    final value = '${cambiarFormatoFecha(formatDate(fechaActual, formats))}';

    return value;
  }

  static double getDoubleValue(String? value) {
    if (value == null) return 0.0;
    // TODO Usar expresión regular para quitar caracteres y espacios (menos caracter "." (punto))
    String rawValue = value == '' ? '0' : value;
    rawValue = rawValue.replaceAll(' ', '');
    rawValue = rawValue.replaceAll('\COP', '');
    rawValue = rawValue.replaceAll('\$', '');
    rawValue = rawValue.replaceAll(',', '');
    return double.parse(rawValue);
  }
}
