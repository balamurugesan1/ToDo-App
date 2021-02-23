import 'package:intl/intl.dart';

class DateUtil {
  static const DATE = "yyyy-MM-dd";

  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE).format(dateTime);
  }
}
