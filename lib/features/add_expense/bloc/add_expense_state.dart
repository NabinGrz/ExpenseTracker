import 'package:flutter/material.dart';

@immutable
abstract class AddExpenseState {}

class AddExpenseInitialState extends AddExpenseState {
  AddExpenseInitialState();
}

class AddExpenseWidgetState extends AddExpenseState {
  final TextEditingController? expenseNameController;
  final TextEditingController? amountController;
  final TextEditingController? expenseCategoryController;
  AddExpenseWidgetState(
      {this.expenseNameController,
      this.amountController,
      this.expenseCategoryController});
}
