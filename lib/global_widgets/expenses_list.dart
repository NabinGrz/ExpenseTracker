import 'dart:math';

import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/global_widgets/category_image_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../core/constants/app_styles.dart';
import '../core/utils/firebase_query_handler.dart';
import '../features/dashboard/models/expense_model.dart';

class ExpenseListTile extends StatelessWidget {
  final DateTime startDate;
  ExpenseListTile({super.key, required this.startDate});
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return expensesListWidget();
  }

  Widget expensesListWidget() {
    return StreamBuilder(
        stream: FirebaseQueryHelper.getCollectionsAsStream(
            collectionPath: "expenses"),
        builder: (calendarBloc, snapshot) {
          List<ExpenseDataModel> todaysExpenseList = [];
          int totalAmount = 0;
          Map<String, List<ExpenseDataModel>> categoryGroupedExpensList = {};
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
              categoryGroupedExpensList =
                  todaysExpenseList.groupByE((val) => val.expense_categories);
            }
          }
          return todaysExpenseList.isEmpty
              ? Center(
                  child: Text(
                    "No Expenses Found!!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppFontSize.fontSize16,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                        child: flChartPieChart(
                            categoryGroupedExpensList:
                                categoryGroupedExpensList)),
                    // pieChartWidget(
                    //     context: calendarBloc,
                    //     categoryGroupedExpensList: categoryGroupedExpensList),
                    Expanded(
                      // flex: 1,
                      child: Scrollbar(
                        controller: controller,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: todaysExpenseList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              surfaceTintColor: Colors.transparent,
                              child: ListTile(
                                leading: imageCard(
                                    categoryName: todaysExpenseList[index]
                                        .expense_categories),
                                title: Text(
                                  todaysExpenseList[index].expense_name,
                                  style: TextStyle(
                                    fontSize: AppFontSize.fontSize14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(todaysExpenseList[index]
                                    .expense_categories),
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
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  Widget pieChartWidget(
      {required BuildContext context,
      required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList}) {
    categoryGroupedExpensList.forEach((key, value) {});

    List<PieChartModel> listCategoryGroupedExpens = [];

    categoryGroupedExpensList.forEach((key, value) {
      listCategoryGroupedExpens.add(PieChartModel(key, value));
    });

    return SfCircularChart(margin: EdgeInsets.zero, series: <CircularSeries>[
      PieSeries<PieChartModel, String>(
          dataSource: listCategoryGroupedExpens,
          // sortingOrder: ,
          xValueMapper: (PieChartModel data, _) => data.x,
          yValueMapper: (PieChartModel data, _) => data.y.length,
          pointRadiusMapper: (PieChartModel data, _) =>
              "${data.y.length * 25.h}%")
    ]);
  }
}

Widget flChartPieChart(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList}) {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  Colors.primaries[generatedColor];
  List<PieChartSectionData>? sections = [];
  List<ExpenseDataModel>? expenses = [];
  List<Color> pieColors = [];
  List<String> pieNames = [];
  List<double> totalAmounts = [];
  pieNames.clear();
  totalAmounts.clear();
  pieColors.clear();
  for (var element in categoryGroupedExpensList.keys) {
    pieNames.add(element);
  }
  // categoryGroupedExpensList.forEach((key, value) {
  //   expenses.add(value);
  // });

  for (int i = 0; i < categoryGroupedExpensList.length; i++) {
    // categoryGroupedExpensList[pieNames[i]]?.forEach((element) {
    //   totalAmounts.add(double.parse(element.amount));
    // });
    // var test = categoryGroupedExpensList[0];
    // print(test);
    pieColors.add(Colors.primaries[i]);
    var pieTitles = categoryGroupedExpensList[pieNames[i]];
    sections.add(PieChartSectionData(
      value: pieTitles?.length.toDouble(),
      title:
          "${pieNames[i]}\n${categoryGroupedExpensList[pieNames[i]]?.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
      color: Colors.primaries[i],
      radius: 100,
      titleStyle: TextStyle(
          fontSize: AppFontSize.fontSize12,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    ));
  }
  print(totalAmounts.toString());
  return PieChart(PieChartData(centerSpaceRadius: 30, sections: sections));
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}

class PieChartModel {
  PieChartModel(
    this.x,
    this.y,
  );
  final String x;
  final List<ExpenseDataModel> y;
}
