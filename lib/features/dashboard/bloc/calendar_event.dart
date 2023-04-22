import 'package:flutter/material.dart';

@immutable
abstract class CalendarEventMain {}

class CalendarDaySelectedEvent extends CalendarEventMain {
  final DateTime selectedDay;
  CalendarDaySelectedEvent({
    required this.selectedDay,
  });
}
