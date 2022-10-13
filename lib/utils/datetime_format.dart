import 'package:appalimentacion/utils/capitalization.dart';
import 'package:intl/intl.dart';

class DateTimeFormat {
  static String dateNow() {
    return DateFormat('EEEE dd MMMM yyy', 'es_ES')
        .format(DateTime.now())
        .toTitleCase();
  }

  static String mmmmYYYY(DateTime date) {
    return DateFormat('MMMM - yyyy', 'es_CO').format(date).toTitleCase();
  }
}
