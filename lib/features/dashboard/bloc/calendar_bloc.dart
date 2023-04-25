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

  final _expenseNameListController = BehaviorSubject<List<ExpenseDataModel>>();
  final List<ExpenseDataModel> _expenseNameList = [];
  Stream<List<ExpenseDataModel>> get expenseNameListStream =>
      _expenseNameListController.stream;
}
