import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  DateTime format([String pattern = "MMMM dd yyyy"]) {
    var dateFormat = DateFormat(pattern);

    var result = dateFormat.parse(dateFormat.format(this));
    return result;
  }
}