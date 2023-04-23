import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/bloc/calendar_event.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEventMain, CalendarState> {
  CalendarBloc() : super(CalendarInitialState()) {
    on<CalendarDaySelectedEvent>((event, emit) =>
        emit(CalendarDaySelectedState(selectedDate: event.selectedDay)));
  }
  updateExpenses() async {
    var data = await FirebaseQueryHelper.getCollectionsAsFuture(
        collectionPath: "expenses");
    _expenseNameList.clear();
    if (data?.docs != null) {
      for (var element in data!.docs) {
        _expenseNameList.add(ExpenseDataModel.fromJson(element.data()));
      }
    }
    _expenseNameListController.add(_expenseNameList);
  }

  // final _widgetListController = StreamController<List<String>>.broadcast();
  //**NOTE these two are same thing */
  final _expenseNameListController = BehaviorSubject<List<ExpenseDataModel>>();
  final List<ExpenseDataModel> _expenseNameList = [];
  Stream<List<ExpenseDataModel>> get expenseNameListStream =>
      _expenseNameListController.stream;

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
