import 'package:flutter/material.dart';

@immutable
abstract class AddExpenseEventMain {}

class AddExpenseWidgetEvent extends AddExpenseEventMain {
  final TextEditingController? expenseNameController;
  final TextEditingController? amountController;
  final TextEditingController? expenseCategoryController;
  AddExpenseWidgetEvent(
      {this.expenseNameController,
      this.amountController,
      this.expenseCategoryController});
}

class FromBankEvent extends AddExpenseEventMain {
  FromBankEvent();
}

class FromCashEvent extends AddExpenseEventMain {
  FromCashEvent();
}

// class AddExpensePasswordUpdateEvent extends AddExpenseEventMain {
//   final String password;
//   AddExpensePasswordUpdateEvent({required this.password});
// }

// class AddExpenseButtonPressedEvent extends AddExpenseEventMain {
//   final AddExpenseDataModel loginDataModel;
//   AddExpenseButtonPressedEvent({required this.loginDataModel});
// }

// class AddExpenseSuccessEvent extends AddExpenseEventMain {
//   AddExpenseSuccessEvent();
// }

// class AddExpenseFailedEvent extends AddExpenseEventMain {
//   final String message;
//   AddExpenseFailedEvent({required this.message});
// }

// class LoggingUserEvent extends AddExpenseEventMain {
//   LoggingUserEvent();
// }
