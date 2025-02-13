import 'package:intl/intl.dart';

import 'capitalization.dart';

class DateTimeFormat {
  static String dateNow() {
    return DateFormat('EEEE dd MMMM yyy', 'es_ES')
        .format(DateTime.now())
        .toTitleCase();
  }

  static String mmmmYYYY(DateTime date) {
    return DateFormat('MMMM - yyyy', 'es_CO').format(date).toTitleCase();
  }

  static String yyyyMMMDD(DateTime date) {
    return DateFormat('yyyy-MMM-dd', 'es_CO')
        .format(date)
        .toTitleCase()
        .toUpperCase()
        .replaceAll('.', '');
  }

  static String ddMMMYYYY(DateTime date) {
    String value =
        DateFormat('dd-MMM-yyyy', 'es_CO').format(date).replaceAll('.', '');

    List<String> list = value.split('-');
    list[1] = list[1][0].toUpperCase() + list[1].substring(1);

    return list.join('-');
  }

  static String? yyyyMMDD(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd', 'es_CO')
        .format(date)
        .toTitleCase()
        .toUpperCase()
        .replaceAll('.', '');
  }

  static String ddMMYYYY(DateTime date) {
    String fecha = date.toString().split(' ')[0];
    List<String> fechaSplit = fecha.split('-');
    String fechaFormateada =
        '${fechaSplit[2]}-${fechaSplit[1]}-${fechaSplit[0]}';
    return fechaFormateada;
  }
}
