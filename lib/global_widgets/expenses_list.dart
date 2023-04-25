import 'package:expensetracker/core/constants/app_colors.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/features/dashboard/bloc/calendar_event.dart';
import 'package:expensetracker/global_widgets/category_image_card.dart';
import 'package:expensetracker/global_widgets/no_expense_found_widget.dart';
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

class ExpenseListTile extends StatelessWidget {
  DateTime startDate;
  final bool isFilterTab;
  ExpenseListTile(
      {super.key, required this.startDate, this.isFilterTab = false});

  final ScrollController controller = ScrollController();
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return expensesListWidget();
  }

  Widget expensesListWidget() {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (calendarBloc, state) {
          if (state is CalendarStartDaySelectedState) {
            startDate = state.startDate ?? DateTime.now();
          } else if (state is CalendarEndDaySelectedState) {
            endDate = state.endDate ?? DateTime.now();
          }
        },
        builder: (calendarBloc, state) {
          return StreamBuilder(
              stream: FirebaseQueryHelper.getCollectionsAsStream(
                  collectionPath: "expenses"),
              builder: (calendarBloc, snapshot) {
                List<ExpenseDataModel> todaysExpenseList = [];
                int totalAmount = 0;
                Map<String, List<ExpenseDataModel>> categoryGroupedExpensList =
                    {};
                if (snapshot.data != null) {
                  totalAmount = 0;
                  todaysExpenseList.clear();
                  for (var element in snapshot.data!.docs) {
                    Map<String, dynamic> finalData = {
                      ...element.data(),
                      'id': element.id
                    };
                    var exp = ExpenseDataModel.fromJson(finalData);
                    var createdDate = exp.created_at
                        .toDate()
                        .dateFormat("yyyy-MM-dd HH:mm:ss.00000")
                        .toDate();
                    if (!isFilterTab) {
                      if (createdDate.isAfter(startDate)) {
                        todaysExpenseList.add(exp);
                        totalAmount = totalAmount + int.parse(exp.amount);
                      }
                    } else {
                      if (createdDate.isAfter(startDate) &&
                          createdDate
                              .isBefore(endDate.add(const Duration(days: 1)))) {
                        todaysExpenseList.add(exp);
                        totalAmount = totalAmount + int.parse(exp.amount);
                      }
                    }
                    categoryGroupedExpensList = todaysExpenseList
                        .groupByE((val) => val.expense_categories);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isFilterTab)
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            Container(
                              height: 12.h,
                              width: 12.h,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            Text(
                              "Analytics",
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      if (isFilterTab) filterWidget(context: calendarBloc),
                      sizedBox(height: 8.h),
                      todaysExpenseList.isEmpty
                          ? noExpenseFoundWidget(isFilterTab)
                          : Expanded(
                              flex: 1,
                              child: pieChartTotalAmountWidget(
                                  todaysExpenseList,
                                  categoryGroupedExpensList)),
                      sizedBox(height: 12.h),
                      todaysExpenseList.isEmpty
                          ? Container()
                          : Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 6,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.h,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                                Text(
                                  "Expenses",
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                      todaysExpenseList.isEmpty
                          ? Container()
                          : Text(
                              "Total Expense: ${todaysExpenseList.length}",
                              style: TextStyle(
                                fontSize: AppFontSize.fontSize12,
                                color: Colors.grey,
                                // fontWeight: FontWeight.w600,
                              ),
                            ),
                      sizedBox(height: 5.h),
                      todaysExpenseList.isEmpty
                          ? Container()
                          : Expanded(
                              flex: 1,
                              child: Scrollbar(
                                controller: controller,
                                child: expenseListView(
                                    todaysExpenseList: todaysExpenseList),
                              ),
                            ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget expenseListView({required List<ExpenseDataModel> todaysExpenseList}) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: todaysExpenseList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(2),
          // surfaceTintColor: Colors.transparent,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: [
            Container(
              height: 12.h,
              width: 12.h,
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
            ),
            Text(
              "Analytics",
              style: TextStyle(
                fontSize: AppFontSize.fontSize18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
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
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      side: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.3)))),
              child: Text(endDate.dateFormat('yMMMMd')),
            ),
          ],
        ),
      ],
    );
  }
}
