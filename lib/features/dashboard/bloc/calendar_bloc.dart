import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/bloc/calendar_event.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEventMain, CalendarState> {
  CalendarBloc() : super(CalendarInitialState()) {
    on<CalendarDateRangeSelectedEvent>(
        (event, emit) => emit(CalendarDateRangeSelectedState()));
    on<CalendarStartDaySelectedEvent>((event, emit) =>
        emit(CalendarStartDaySelectedState(startDate: event.startDate)));
    on<CalendarEndDaySelectedEvent>((event, emit) =>
        emit(CalendarEndDaySelectedState(endDate: event.endDate)));
    on<TabChangedSelectedEvent>((event, emit) =>
        emit(TabChangedSelectedState(tabIndex: event.tabIndex)));
  }
  updateExpenses() async {
    var data = await FirebaseQueryHelper.getCollectionsAsFuture(
        collectionPath: "expenses");
    _expenseList.clear();
    if (data?.docs != null) {
      for (var element in data!.docs) {
        _expenseList.add(ExpenseDataModel.fromJson(element.data()));
      }
    }
    _expenseListController.add(_expenseList);
  }

  final _expenseListController = BehaviorSubject<List<ExpenseDataModel>>();
  final List<ExpenseDataModel> _expenseList = [];
  Stream<List<ExpenseDataModel>> get expenseListStream =>
      _expenseListController.stream;

  final _totalCashController = BehaviorSubject<double>();
  Stream<double> get totalCashStream => _totalCashController.stream;
  updateTotalCashAmount(double amount) {
    _totalCashController.add(amount);
  }

  final _inBankController = BehaviorSubject<double>();
  Stream<double> get inBankStream => _inBankController.stream;
  updateTotalInBankAmount(double amount) {
    _inBankController.add(amount);
  }

  @override
  Future<void> close() {
    _expenseListController.cast();
    _totalCashController.close();
    _inBankController.close();
    return super.close();
  }
}
