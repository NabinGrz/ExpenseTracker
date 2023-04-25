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
          if (state is CalendarDateRangeSelectedState) {
          } else if (state is CalendarStartDaySelectedState) {
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

                    if (exp.created_at
                        .toDate()
                        .dateFormat("yyyy-MM-dd HH:mm:ss.00000")
                        .toDate()
                        .isAfter(startDate)) {
                      todaysExpenseList.add(exp);
                      totalAmount = totalAmount + int.parse(exp.amount);
                    }
                    categoryGroupedExpensList = todaysExpenseList
                        .groupByE((val) => val.expense_categories);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (isFilterTab) filterWidget(context: calendarBloc),
                      todaysExpenseList.isEmpty
                          ? noExpenseFoundWidget(isFilterTab)
                          : Expanded(
                              flex: 1,
                              child: pieChartTotalAmountWidget(
                                  todaysExpenseList,
                                  categoryGroupedExpensList)),
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
          margin: EdgeInsets.symmetric(vertical: 4.h),
          surfaceTintColor: Colors.transparent,
          child: ListTile(
            leading: categoryImageCard(
                categoryName: todaysExpenseList[index].expense_categories),
            title: Text(
              todaysExpenseList[index].expense_name,
              style: TextStyle(
                fontSize: AppFontSize.fontSize14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(todaysExpenseList[index].expense_categories),
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
                  side: const BorderSide())),
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
                  side: const BorderSide())),
          child: Text(endDate.dateFormat('yMMMMd')),
        ),
      ],
    );
  }
}
