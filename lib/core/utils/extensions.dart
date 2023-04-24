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

extension GroupByExtension<T> on List<T> {
  Map<K, List<T>> groupByE<K>(K Function(T) keySelector) {
    final groups = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      groups.putIfAbsent(key, () => []).add(element);
    }
    return groups;
  }
}

extension IntArithmeticExtensions on List<int> {
  int get sumOfIntegersInList => length == 0 ? 0 : reduce((a, b) => a + b);
}

extension DoubleArithmeticExtensions on List<double> {
  double get sumOfDoublesInList => length == 0 ? 0 : reduce((a, b) => a + b);
}
