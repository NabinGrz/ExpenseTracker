import 'package:flutter/material.dart';

@immutable
abstract class CalendarEventMain {}

class CalendarDateRangeSelectedEvent extends CalendarEventMain {}

class CalendarStartDaySelectedEvent extends CalendarEventMain {
  final DateTime? startDate;
  CalendarStartDaySelectedEvent({
    this.startDate,
  });
}

class CalendarEndDaySelectedEvent extends CalendarEventMain {
  final DateTime? endDate;
  CalendarEndDaySelectedEvent({
    this.endDate,
  });
}

class TabChangedSelectedEvent extends CalendarEventMain {
  final int tabIndex;
  TabChangedSelectedEvent({
    required this.tabIndex,
  });
}
