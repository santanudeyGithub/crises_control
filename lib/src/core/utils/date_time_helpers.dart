import 'package:intl/intl.dart';

class DateTimeHelpers {
  static String getFormattedDateToString(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
