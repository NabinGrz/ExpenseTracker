import 'package:expensetracker/core/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/utils/firebase_query_handler.dart';
import '../../dashboard/bloc/calendar_bloc.dart';
import '../../dashboard/bloc/calendar_state.dart';
import '../../dashboard/models/expense_model.dart';
import '../../dashboard/widgets/add_expense_dialog.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  List<ExpenseDataModel> todaysExpenseList = [];
  int totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: DefaultTabController(
        length: 4,
        child: BlocConsumer<CalendarBloc, CalendarState>(
          listener: (calendarBloc, state) {
            if (state is CalendarDaySelectedState) {
              showSnackBar(message: state.selectedDate.toString());
              todaysExpenseList.clear();
            }
          },
          builder: (calendarBloc, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                bottom: TabBar(
                  onTap: (value) async {
                    // calendarBloc.read<CalendarBloc>().add(
                    //     CalendarDaySelectedEvent(selectedDay: DateTime.now()));
                    await calendarBloc.read<CalendarBloc>().updateExpenses();
                  },
                  tabs: const [
                    Tab(icon: Text("7 Days")),
                    Tab(icon: Text("14 Days")),
                    Tab(icon: Text("1 Month")),
                    Tab(icon: Text("Filter")),
                  ],
                ),
                title: const Text('Full Expenses'),
              ),
              body: TabBarView(
                children: [
                  expenses(calendarBloc),
                  const Icon(Icons.directions_transit, size: 350),
                  const Icon(Icons.directions_car, size: 350),
                  const Icon(Icons.directions_car, size: 350),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget expenses(BuildContext calendarBloc) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (calendarBloc, state) {
          if (state is CalendarState) {}
        },
        builder: (calendarBloc, state) {
          return StreamBuilder(
              stream: calendarBloc.read<CalendarBloc>().expenseNameListStream,
              // FirebaseQueryHelper.getCollectionsAsStream(
              //     collectionPath: "expenses"),
              builder: (calendarBloc, snapshot) {
                if (snapshot.data != null) {
                  totalAmount = 0;
                  todaysExpenseList.clear();
                  for (var element in snapshot.data!) {
                    Map<String, dynamic> finalData = {
                      ...element.toJson(),
                      'id': element.id
                    };
                    var exp = ExpenseDataModel.fromJson(finalData);
                    // if (exp.created_at.toDate().dateFormat("yMd") ==
                    //     DateTime.now().dateFormat("yMd")) {
                    todaysExpenseList.add(exp);
                    totalAmount = totalAmount + int.parse(exp.amount);
                    // }
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sizedBox(
                    //   height: 20.h,
                    // ),
                    // Text(
                    //   "Today's Expense",
                    //   style: TextStyle(
                    //     fontSize: AppFontSize.fontSize18,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // Text(
                    //   "Total: Rs $totalAmount",
                    //   style: TextStyle(
                    //       fontSize: AppFontSize.fontSize12,
                    //       fontWeight: FontWeight.w300,
                    //       color: Colors.grey),
                    // ),
                    // sizedBox(
                    //   height: 10.h,
                    // ),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      // itemCount: todaysExpenseList.where((v) {
                      //   var createdDate =
                      //       v.created_at.toDate().dateFormat("yMd");
                      //   var currentDay =
                      //       DateTime.now().dateFormat("yMd");
                      //   return createdDate == currentDay;
                      // }).length,
                      itemCount: todaysExpenseList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Card(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            FirebaseQueryHelper.deleteDocumentOfCollection(
                                collectionID: "expenses",
                                docID: todaysExpenseList[index].id ?? "-1");
                          },
                          child: Card(
                            child: ListTile(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddExpenseDialog(
                                      isEdit: true,
                                      expenseDataModel:
                                          todaysExpenseList[index],
                                    );
                                  },
                                );
                              },
                              title: Text(
                                todaysExpenseList[index].expense_name,
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                  todaysExpenseList[index].expense_categories),
                              trailing: Text(
                                "Rs: ${todaysExpenseList[index].amount}",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
