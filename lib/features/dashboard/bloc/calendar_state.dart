import 'package:flutter/material.dart';

@immutable
abstract class CalendarState {}

class CalendarInitialState extends CalendarState {
  CalendarInitialState();
}

class CalendarStartDaySelectedState extends CalendarState {
  final DateTime? startDate;
  CalendarStartDaySelectedState({
    this.startDate,
  });
}

class CalendarEndDaySelectedState extends CalendarState {
  final DateTime? endDate;
  CalendarEndDaySelectedState({
    this.endDate,
  });
}

class CalendarDateRangeSelectedState extends CalendarState {}
