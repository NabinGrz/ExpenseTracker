import 'package:flutter/material.dart';

import '../models/expense_model.dart';

@immutable
abstract class ExpenseEvent {}

class BlocDateRangeSelectedEvent extends ExpenseEvent {}

class BlocStartDaySelectedEvent extends ExpenseEvent {
  final DateTime startDate;
  BlocStartDaySelectedEvent({
    required this.startDate,
  });
}

class BlocEndDaySelectedEvent extends ExpenseEvent {
  final DateTime endDate;
  BlocEndDaySelectedEvent({
    required this.endDate,
  });
}

class TabChangedSelectedEvent extends ExpenseEvent {
  final int tabIndex;
  TabChangedSelectedEvent({
    required this.tabIndex,
  });
}
class DaySelectedEvent extends ExpenseEvent {
  final DateTime selectedDate;
  DaySelectedEvent({
    required this.selectedDate,
  });
}

// class SearchingExpenseNameEvent extends BlocEventMain {
//   final String name;
//   SearchingExpenseNameEvent({
//     required this.name,
//   });
// }
class SearchingExpenseNameEvent extends ExpenseEvent {
  final List<ExpenseDataModel> expenseList;
  SearchingExpenseNameEvent({
    required this.expenseList,
  });
}

class NotSearchingEvent extends ExpenseEvent {}
