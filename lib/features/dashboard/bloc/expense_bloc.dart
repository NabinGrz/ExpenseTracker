import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitialState()) {
    on<BlocDateRangeSelectedEvent>(
        (event, emit) => emit(ExpenseDateRangeSelectedState()));
    on<BlocStartDaySelectedEvent>((event, emit) =>
        emit(ExpenseStartDaySelectedState(startDate: event.startDate)));
    on<BlocEndDaySelectedEvent>((event, emit) =>
        emit(ExpenseEndDaySelectedState(endDate: event.endDate)));
    on<TabChangedSelectedEvent>((event, emit) =>
        emit(TabChangedSelectedState(tabIndex: event.tabIndex)));
    on<SearchingExpenseNameEvent>((event, emit) =>
        emit(SearchingExpenseNameState(expenseList: event.expenseList)));
    on<NotSearchingEvent>((event, emit) => emit(NotSearchingState()));
  }

  final List<ExpenseDataModel> _expenseList = [];
  final _expenseListController = BehaviorSubject<List<ExpenseDataModel>>();
  final _inBankController = BehaviorSubject<double>();
  final _searchNameController = BehaviorSubject<String>();
  final _totalCashController = BehaviorSubject<double>();

  @override
  Future<void> close() {
    _expenseListController.cast();
    _totalCashController.close();
    _inBankController.close();
    _searchNameController.close();
    return super.close();
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

  Stream<List<ExpenseDataModel>> get expenseListStream =>
      _expenseListController.stream;

  Stream<double> get totalCashStream => _totalCashController.stream;

  updateTotalCashAmount(double amount) {
    _totalCashController.add(amount);
  }

  Stream<double> get inBankStream => _inBankController.stream;

  updateTotalInBankAmount(double amount) {
    _inBankController.add(amount);
  }

  Stream<String> get searchNameStream => _searchNameController.stream;

  updateSearchName(String name, List<ExpenseDataModel> expenseList) {
    if (name.isNotEmpty) {
      _searchNameController.add(name);

      onSearchExpense(name, expenseList);
    } else {
      add(NotSearchingEvent());
      onSearchExpense(name, expenseList);
    }
  }

  onSearchExpense(String name, List<ExpenseDataModel> expenseList) {
    var list = expenseList
        .where((element) =>
            element.expense_name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    _expenseList.clear();
    _expenseList.addAll(list);
    _expenseListController.add(_expenseList);
  }
}
