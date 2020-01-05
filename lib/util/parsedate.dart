import 'package:intl/intl.dart';

class ParseDate {
  static final DateTime _date = DateTime.now();

  static String showDay(DateTime date) {
    final f = new DateFormat("EEEE");
    return f.format(date);
  }
}