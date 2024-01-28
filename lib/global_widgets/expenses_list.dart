import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/core/constants/app_colors.dart';
import 'package:expensetracker/core/utils/clear_focus.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/features/dashboard/bloc/expense_event.dart';
import 'package:expensetracker/global_widgets/category_image_card.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:expensetracker/global_widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_styles.dart';
import '../core/utils/firebase_query_handler.dart';
import '../features/dashboard/bloc/expense_bloc.dart';
import '../features/dashboard/bloc/expense_state.dart';
import '../features/dashboard/models/expense_model.dart';
import '../features/dashboard/widgets/add_expense_dialog.dart';
import '../features/dashboard/widgets/piechart_total_amount.dart';
import 'no_expense_found_widget.dart';

class ExpenseListTile extends StatelessWidget {
  DateTime startDate;
  TextEditingController searchController = TextEditingController();
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
    return BlocProvider(
      create: (context) => ExpenseBloc(),
      child: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (calendarBloc, state) {
          if (state is ExpenseStartDaySelectedState) {
            startDate = state.startDate
                .dateFormat("yyyy-MM-dd HH:mm:ss.00000")
                .toDate();
          } else if (state is ExpenseEndDaySelectedState) {
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
                                  text: 'Analytics',
                                ),
                                Tab(
                                  text: 'Expenses',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              expenseTabView(todaysExpenseList,
                                  categoryGroupedExpensList, calendarBloc),
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
          child: GestureDetector(
            onDoubleTap: () {
              FirebaseQueryHelper.deleteDocumentOfCollection(
                  collectionID: "expenses",
                  docID: todaysExpenseList[index].id ?? "-1");
            },
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
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
              leading: categoryImageCard(
                  categoryName: todaysExpenseList[index].expense_categories),
              title: Text(
                todaysExpenseList[index].expense_name.capitialize,
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
                .read<ExpenseBloc>()
                .add(BlocStartDaySelectedEvent(startDate: selectedDay));
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
                .read<ExpenseBloc>()
                .add(BlocEndDaySelectedEvent(endDate: selectedDay));
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

  Widget expenseTabView(
    List<ExpenseDataModel> todaysExpenseList,
    Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
    BuildContext context,
  ) {
    return todaysExpenseList.isEmpty
        ? noExpenseFoundWidget(isFilterTab)
        : pieChartTotalAmountWidget(
            todaysExpenseList,
            context,
            categoryGroupedExpensList,
          );
  }

  Widget analyticsTabView(
      List<ExpenseDataModel> expenseList,
      Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
      BuildContext calendarBloc) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          if (isFilterTab) filterWidget(context: calendarBloc),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              controller: searchController,
              hintText: "Dairy Milk",
              icon: const Icon(CupertinoIcons.search),
              onClear: () {
                calendarBloc
                    .read<ExpenseBloc>()
                    .updateSearchName("", expenseList);
                clearFocus();
                searchController.clear();
              },
              onChanged: (val) {
                calendarBloc
                    .read<ExpenseBloc>()
                    .updateSearchName(val, expenseList);
              },
            ),
          ),
          expenseList.isEmpty
              ? noExpenseFoundWidget(isFilterTab)
              : Scrollbar(
                  controller: controller,
                  child: BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      return StreamBuilder(
                          stream: calendarBloc
                              .read<ExpenseBloc>()
                              .expenseListStream,
                          builder: (context, snapshot) {
                            return expenseListView(
                                todaysExpenseList:
                                    snapshot.data ?? expenseList);
                          });
                      // if (state is SearchingExpenseNameState) {
                      //   // var list = expenseList
                      //   //     .where((element) => element.expense_name
                      //   //         .toLowerCase()
                      //   //         .contains(state.name.toLowerCase()))
                      //   //     .toList();
                      //   return expenseListView(
                      //       todaysExpenseList: state.expenseList);
                      // }
                      // return expenseListView(todaysExpenseList: expenseList);
                    },
                  ),
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

      DateTime createdDate = DateTime(exp.created_at.toDate().year,
          exp.created_at.toDate().month, exp.created_at.toDate().day);
      DateTime newStartDate =
          DateTime(startDate.year, startDate.month, startDate.day);
      bool isAfter = createdDate.isAfter(newStartDate);
      switch (isFilterTab) {
        case false:
          if (isAfter) {
            todaysExpenseList.add(exp);
            totalAmount =
                totalAmount + int.parse(exp.amount.isEmpty ? "0" : exp.amount);
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
