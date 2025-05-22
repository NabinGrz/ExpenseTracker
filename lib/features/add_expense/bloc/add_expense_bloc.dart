import 'dart:async';

import 'package:expensetracker/features/add_expense/bloc/add_expense_event.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEventMain, AddExpenseState> {
  AddExpenseBloc() : super(AddExpenseInitialState()) {
    on<AddExpenseWidgetEvent>((event, emit) => emit(AddExpenseWidgetState(
        expenseNameController: event.expenseNameController,
        amountController: event.amountController,
        expenseCategoryController: event.expenseCategoryController)));
    on<FromBankEvent>((event, emit) => emit(FromBankState()));
    on<FromCashEvent>((event, emit) => emit(FromCashState()));

    add(FromCashEvent());
  }
  final _expenseNameController = BehaviorSubject<String>();
  Stream<String> get expenseNameStream => _expenseNameController.stream;
  updateExpenseName(String expenseName) {
    _expenseNameController.add(expenseName);
  }

  final _expenseCategoryController = BehaviorSubject<String>();
  Stream<String> get expenseCategoryStream => _expenseCategoryController.stream;
  updateExpenseCategory(String expenseCategory) {
    _expenseCategoryController.add(expenseCategory);
  }

  final _expenseAmountController = BehaviorSubject<String>();
  Stream<String> get expenseAmountStream => _expenseAmountController.stream;
  updateExpenseAmount(String expenseAmount) {
    _expenseAmountController.add(expenseAmount);
  }

  Stream<ExpenseDataModel?> get expenseData => Rx.combineLatest3(
          expenseAmountStream, expenseCategoryStream, expenseNameStream,
          (a, b, c) {
        if (a != "" && b != "" && c != "") {
          return ExpenseDataModel(
            expense_categories: b,
            amount: a,
            expense_name: c,
            created_at: DateTime.now().toString(),
          );
        } else {
          return null;
        }
      });

  final deductFromBank = StreamController<bool>.broadcast();
  Stream<bool> watchDeductFromBank() => deductFromBank.stream;

  updateDeductFromBank(bool val) {
    deductFromBank.add(val);
  }

  bool isBank = false;
  // final _widgetListController = StreamController<List<String>>.broadcast();
  //**NOTE these two are same thing */
  // final _expenseNameListController =
  //     BehaviorSubject<List<TextEditingController>>();

  // final List<TextEditingController> _expenseNameList = [];
  // Stream<List<TextEditingController>> get expenseNameListStream =>
  //     _expenseNameListController.stream;

  // final _amountListController =
  //     StreamController<List<TextEditingController>>.broadcast();
  // final List<TextEditingController> _amountList = [];
  // Stream<List<TextEditingController>> get amountListStream =>
  //     _amountListController.stream;

  // final _expenseCategoryListController =
  //     StreamController<List<TextEditingController>>.broadcast();
  // final List<TextEditingController> _expenseCategoryList = [];
  // Stream<List<TextEditingController>> get expenseCategoryListStream =>
  //     _expenseCategoryListController.stream;

  // updateExpenseNameList(TextEditingController textEditingController) {
  //   _expenseNameList.add(textEditingController);
  //   _expenseNameListController.add(_expenseNameList);
  // }

  // updateAmountList(TextEditingController amount) {
  //   _amountList.add(amount);
  //   _amountListController.add(_amountList);
  // }

  // updateExpenseCategoryList(TextEditingController textEditingController) {
  //   _expenseCategoryList.add(textEditingController);
  //   _expenseCategoryListController.add(_expenseCategoryList);
  // }

  // final Map<String, dynamic> _widgetDataMap = {};
  // final List<Map<String, dynamic>> _widgetDataMapList = [];
  // final _widgetDataController =
  //     StreamController<List<Map<String, dynamic>>>.broadcast();
  // Stream<List<Map<String, dynamic>>> get widgetDataListStream =>
  //     _widgetDataController.stream;

  // void updateDatas(
  //     {required TextEditingController expenseNametextEditingController,
  //     required TextEditingController amount,
  //     required TextEditingController expenseCategorytextEditingController}) {
  //   updateExpenseNameList(expenseNametextEditingController);
  //   updateAmountList(amount);
  //   updateExpenseCategoryList(expenseCategorytextEditingController);
  // }

  // void updateWidgetsData(Map<String, dynamic> data) {
  //   _widgetDataMap.addAll(data);
  //   _widgetDataMapList.add(_widgetDataMap);
  //   _widgetDataController.add(_widgetDataMapList);
  // }

  // Stream<Map<String, dynamic>> get widgetsData => Rx.combineLatest3(
  //         expenseNameListStream, amountListStream, expenseCategoryListStream,
  //         (a, b, c) {
  //       return {
  //         'expenseName': a,
  //         'amount': b,
  //         'category': c,
  //       };
  //     });
  // @override
  // Future<void> close() {
  //   dispose();
  //   return super.close();
  // }

  // void dispose() {
  //   _expenseNameListController.close();
  // }
}
