import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String dateFormat(String val) {
    return DateFormat(val).format(this);
  }
}

extension StringToDate on String {
  DateTime toDate() {
    return DateTime.parse(this);
  }
}
