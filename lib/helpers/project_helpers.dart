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
}
