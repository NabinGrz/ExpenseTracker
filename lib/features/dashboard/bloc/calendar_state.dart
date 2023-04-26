import 'package:flutter/material.dart';

@immutable
abstract class CalendarState {}

class CalendarInitialState extends CalendarState {
  CalendarInitialState();
}

class CalendarStartDaySelectedState extends CalendarState {
  final DateTime startDate;
  CalendarStartDaySelectedState({
    required this.startDate,
  });
}

class CalendarEndDaySelectedState extends CalendarState {
  final DateTime endDate;
  CalendarEndDaySelectedState({
    required this.endDate,
  });
}

class CalendarDateRangeSelectedState extends CalendarState {}

class TabChangedSelectedState extends CalendarState {
  final int tabIndex;
  TabChangedSelectedState({
    required this.tabIndex,
  });
}
