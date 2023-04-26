import 'package:expensetracker/core/constants/app_colors.dart';
import 'package:expensetracker/features/dashboard/bloc/calendar_event.dart';
import 'package:expensetracker/global_widgets/expenses_list.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/cupertino.dart';
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
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: DefaultTabController(
        length: 5,
        child: BlocConsumer<CalendarBloc, CalendarState>(
          listener: (calendarBloc, state) {
            if (state is TabChangedSelectedState) {
              // showSnackBar(message: state.tabIndex.toString());
              tabIndex = state.tabIndex;
            }
          },
          builder: (calendarBloc, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('Full Expenses'),
              ),
              body: Column(
                children: [
                  sizedBox(height: 2.h),
                  Container(
                    height: 40.h,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    // decoration: BoxDecoration(
                    //     // color: Colors.grey[300],
                    //     borderRadius: BorderRadius.circular(8.0.r)),
                    child: TabBar(
                      onTap: (value) {
                        calendarBloc
                            .read<CalendarBloc>()
                            .add(TabChangedSelectedEvent(tabIndex: value));
                      },
                      indicator: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.0.r)),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      tabs: const [
                        Tab(
                          text: 'Todays',
                        ),
                        Tab(
                          text: '1 Week',
                        ),
                        Tab(
                          text: '2 Week',
                        ),
                        Tab(
                          text: '1 Month',
                        ),
                        Tab(
                          text: 'Filter',
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ExpenseListTile(
                          startDate:
                              DateTime.now().subtract(const Duration(days: 1)),
                        ),
                        ExpenseListTile(
                            startDate: DateTime.now()
                                .subtract(const Duration(days: 7))),
                        ExpenseListTile(
                          startDate:
                              DateTime.now().subtract(const Duration(days: 14)),
                        ),
                        ExpenseListTile(
                          startDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                        ),
                        ExpenseListTile(
                          isFilterTab: true,
                          startDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: tabIndex != 0
                  ? null
                  : FloatingActionButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddExpenseDialog();
                          },
                        );
                      },
                      child: const Icon(CupertinoIcons.add),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget expenses(BuildContext calendarBloc) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (calendarBloc, state) {
        return StreamBuilder(
            stream: calendarBloc.read<CalendarBloc>().expenseListStream,
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

                  todaysExpenseList.add(exp);
                  totalAmount = totalAmount + int.parse(exp.amount);
                }
              }
              return ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
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
                                expenseDataModel: todaysExpenseList[index],
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
                        subtitle:
                            Text(todaysExpenseList[index].expense_categories),
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
              );
            });
      },
    );
  }
}
