import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/core/constants/app_colors.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/features/dashboard/bloc/calendar_event.dart';
import 'package:expensetracker/global_widgets/category_image_card.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_styles.dart';
import '../core/utils/firebase_query_handler.dart';
import '../features/dashboard/bloc/calendar_bloc.dart';
import '../features/dashboard/bloc/calendar_state.dart';
import '../features/dashboard/models/expense_model.dart';
import '../features/dashboard/widgets/piechart_total_amount.dart';
import 'no_expense_found_widget.dart';

class ExpenseListTile extends StatelessWidget {
  DateTime startDate;
  final bool isFilterTab;
  ExpenseListTile(
      {super.key, required this.startDate, this.isFilterTab = false});

  final ScrollController controller = ScrollController();
  DateTime endDate = DateTime.now();
  List<ExpenseDataModel> todaysExpenseList = [];
  int totalAmount = 0;
  Map<String, List<ExpenseDataModel>> categoryGroupedExpensList = {};
  @override
  Widget build(BuildContext context) {
    return expensesListWidget();
  }

  Widget expensesListWidget() {
    print(startDate);
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (calendarBloc, state) {
          if (state is CalendarStartDaySelectedState) {
            startDate = state.startDate
                .dateFormat("yyyy-MM-dd HH:mm:ss.00000")
                .toDate();
          } else if (state is CalendarEndDaySelectedState) {
            endDate =
                state.endDate.dateFormat("yyyy-MM-dd HH:mm:ss.00000").toDate();
          }
        },
        builder: (calendarBloc, state) {
          return StreamBuilder(
              stream: FirebaseQueryHelper.getCollectionsAsStream(
                  collectionPath: "expenses"),
              builder: (calendarBloc, snapshot) {
                if (snapshot.data != null) {
                  filterDataAndAssignValues(snapshot: snapshot);
                }
                return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20.0.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20.0.r)),
                              labelColor: Colors.white,
                              indicatorColor: Colors.red,
                              automaticIndicatorColorAdjustment: false,
                              indicatorSize: TabBarIndicatorSize.tab,
                              unselectedLabelColor: Colors.grey,
                              unselectedLabelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              tabs: const [
                                Tab(
                                  text: 'Expenses',
                                ),
                                Tab(
                                  text: 'Analytics',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              expenseTabView(
                                  todaysExpenseList, categoryGroupedExpensList),
                              analyticsTabView(todaysExpenseList,
                                  categoryGroupedExpensList, calendarBloc),
                            ],
                          ),
                        ),
                      ],
                    ));
              });
        },
      ),
    );
  }

  Widget expenseListView({required List<ExpenseDataModel> todaysExpenseList}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: todaysExpenseList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(2),
          child: ListTile(
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
            leading: categoryImageCard(
                categoryName: todaysExpenseList[index].expense_categories),
            title: Text(
              todaysExpenseList[index].expense_name,
              style: TextStyle(
                fontSize: AppFontSize.fontSize14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              todaysExpenseList[index].expense_categories,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(
              "Rs: ${todaysExpenseList[index].amount}",
              style: TextStyle(
                fontSize: AppFontSize.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget filterWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            var selectedDay = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime(2023, 1, 1),
                  lastDate: DateTime.now(),
                ) ??
                DateTime.now();

            context
                .read<CalendarBloc>()
                .add(CalendarStartDaySelectedEvent(startDate: selectedDay));
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side: BorderSide(
                      color: AppColors.primaryColor.withOpacity(0.3)))),
          child: Text(startDate.dateFormat('yMMMMd')),
        ),
        sizedBox(width: 4.w),
        TextButton(
          onPressed: () async {
            var selectedDay = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023, 1, 1),
                  lastDate: DateTime.now(),
                ) ??
                DateTime.now();

            context
                .read<CalendarBloc>()
                .add(CalendarEndDaySelectedEvent(endDate: selectedDay));
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side: BorderSide(
                      color: AppColors.primaryColor.withOpacity(0.3)))),
          child: Text(endDate.dateFormat('yMMMMd')),
        ),
      ],
    );
  }

  Widget expenseTabView(List<ExpenseDataModel> todaysExpenseList,
      Map<String, List<ExpenseDataModel>> categoryGroupedExpensList) {
    return todaysExpenseList.isEmpty
        ? noExpenseFoundWidget(isFilterTab)
        : pieChartTotalAmountWidget(
            todaysExpenseList, categoryGroupedExpensList);
  }

  Widget analyticsTabView(
      List<ExpenseDataModel> todaysExpenseList,
      Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
      BuildContext calendarBloc) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isFilterTab) filterWidget(context: calendarBloc),
          todaysExpenseList.isEmpty
              ? noExpenseFoundWidget(isFilterTab)
              : Scrollbar(
                  controller: controller,
                  child: expenseListView(todaysExpenseList: todaysExpenseList),
                ),
        ],
      ),
    );
  }

  void filterDataAndAssignValues(
      {required AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot}) {
    totalAmount = 0;
    todaysExpenseList.clear();
    for (var element in snapshot.data!.docs) {
      Map<String, dynamic> finalData = {...element.data(), 'id': element.id};
      ExpenseDataModel exp = ExpenseDataModel.fromJson(finalData);
      DateTime createdDate = exp.created_at
          .toDate()
          .dateFormat("yyyy-MM-dd HH:mm:ss.00000")
          .toDate();
      DateTime newStartDate =
          DateTime(startDate.year, startDate.month, startDate.day);
      bool isAfter = createdDate.isAfter(newStartDate);
      switch (isFilterTab) {
        case false:
          if (isAfter) {
            todaysExpenseList.add(exp);
            totalAmount = totalAmount + int.parse(exp.amount);
          }
          break;
        case true:
          bool val = createdDate.isAfter(newStartDate) &&
              createdDate.isBefore(endDate.add(const Duration(days: 1)));
          if (val) {
            todaysExpenseList.add(exp);
            totalAmount = totalAmount + int.parse(exp.amount);
          }
          break;
        default:
      }
      categoryGroupedExpensList =
          todaysExpenseList.groupBy((val) => val.expense_categories);
    }
  }
}
