import 'dart:math';

import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_styles.dart';
import '../../../global_widgets/category_image_card.dart';
import '../models/expense_model.dart';

Widget flChartPieChart(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
    required BuildContext context}) {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  Colors.primaries[generatedColor];
  List<PieChartSectionData>? sections = [];

  List<Color> pieColors = [];
  List<String> pieNames = [];
  List<double> totalAmounts = [];
  pieNames.clear();
  totalAmounts.clear();
  pieColors.clear();
  for (var element in categoryGroupedExpensList.keys) {
    pieNames.add(element);
  }

  for (int i = 0; i < categoryGroupedExpensList.length; i++) {
    pieColors.add(Colors.primaries[i]);
    var pieTitles = categoryGroupedExpensList[pieNames[i]];
    sections.add(PieChartSectionData(
      value: categoryGroupedExpensList[pieNames[i]]
          ?.map((e) => double.parse(e.amount))
          .toList()
          .sumOfDoublesInList,
      color: Colors.primaries[i],
      radius: 100,
      titleStyle: TextStyle(
          fontSize: AppFontSize.fontSize12,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    ));
  }
  return PieChart(PieChartData(centerSpaceRadius: 30, sections: sections));
}

Widget expenseCategoryCard(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
    required BuildContext context}) {
  var generatedColor = Random().nextInt(17);
  Colors.primaries[generatedColor];
  List<Widget>? widgets = [];
  List<Color> pieColors = [];
  List<String> pieNames = [];
  List<double> totalAmounts = [];
  pieNames.clear();
  totalAmounts.clear();
  pieColors.clear();
  for (var element in categoryGroupedExpensList.keys) {
    pieNames.add(element);
  }

  for (int i = 0; i < categoryGroupedExpensList.length; i++) {
    categoryGroupedExpensList[pieNames[i]]?.sort(
      (a, b) => double.parse(b.amount).compareTo(double.parse(a.amount)),
    );
    var randomNumber = Random().nextInt(17);
    pieColors.add(Colors.primaries[randomNumber]);

    widgets.add(
        expenseCategoryWidget(context, categoryGroupedExpensList, pieNames, i));
  }

  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: widgets,
  );
}

Widget expenseCategoryWidget(
    BuildContext context,
    Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
    List<String> pieNames,
    int i) {
  var ranNum = Random().nextInt(17);
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        builder: (_) {
          return expenseBottomSheet(
              context, categoryGroupedExpensList[pieNames[i]]);
        },
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 4.h,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.primaries[ranNum],
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            getIconPathByCategory(pieNames[i].toLowerCase()),
            fit: BoxFit.contain,
            height: 40.h,
          ),
          sizedBox(
              height: 16,
              child: Text(
                "Rs ${categoryGroupedExpensList[pieNames[i]]?.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
          Text(
            pieNames[i].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}

Widget expenseBottomSheet(
    BuildContext context, List<ExpenseDataModel>? categoryGroupedExpensList) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Expenses",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: AppFontSize.fontSize16),
        ),
        Text(
          "${categoryGroupedExpensList?.length} items",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: AppFontSize.fontSize14),
        ),
        Scrollbar(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryGroupedExpensList?.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                    "${categoryGroupedExpensList?[index].expense_name.capitialize}"),
                subtitle:
                    Text("Rs ${categoryGroupedExpensList?[index].amount}"),
              );
              // return Text("${categoryGroupedExpensList?[index].expense_name}");
            },
          ),
        )
      ],
    ),
  );
}
