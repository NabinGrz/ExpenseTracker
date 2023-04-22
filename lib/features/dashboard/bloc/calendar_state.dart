import 'package:flutter/material.dart';

@immutable
abstract class CalendarState {}

class CalendarInitialState extends CalendarState {
  CalendarInitialState();
}

class CalendarDaySelectedState extends CalendarState {
  final DateTime selectedDate;
  CalendarDaySelectedState({
    required this.selectedDate,
  });
}
