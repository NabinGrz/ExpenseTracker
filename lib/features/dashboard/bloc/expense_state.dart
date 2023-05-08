import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {
  ExpenseInitialState();
}

class ExpenseStartDaySelectedState extends ExpenseState {
  final DateTime startDate;
  ExpenseStartDaySelectedState({
    required this.startDate,
  });
}

class ExpenseEndDaySelectedState extends ExpenseState {
  final DateTime endDate;
  ExpenseEndDaySelectedState({
    required this.endDate,
  });
}

class ExpenseDateRangeSelectedState extends ExpenseState {}

class SearchingExpenseNameState extends ExpenseState {
  final List<ExpenseDataModel> expenseList;
  SearchingExpenseNameState({
    required this.expenseList,
  });
}

class NotSearchingState extends ExpenseState {}

class TabChangedSelectedState extends ExpenseState {
  final int tabIndex;
  TabChangedSelectedState({
    required this.tabIndex,
  });
}
