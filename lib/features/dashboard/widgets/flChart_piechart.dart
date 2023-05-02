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
      // title:
      // "${pieNames[i].capitialize}\n${categoryGroupedExpensList[pieNames[i]]?.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
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

Widget flChartBarChart(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList,
    required BuildContext context}) {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  Colors.primaries[generatedColor];
  List<Widget>? sections = [];

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
    var height = categoryGroupedExpensList[pieNames[i]]
        ?.map((e) => double.parse(e.amount))
        .toList()
        .sumOfDoublesInList;
    var width = (MediaQuery.of(context).size.width *
        0.75 /
        categoryGroupedExpensList.length);
    sections.add(Container(
      margin: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 4.h,
      ),
      // width: width,
      // height: 55.h,
      // width: 55.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.primaries[i], borderRadius: BorderRadius.circular(8.r)),
      // alignment: Alignment.bottomCenter,
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
            pieNames[i],
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
      // child: ,
    ));
    // sections.add(PieChartSectionData(
    //   value: categoryGroupedExpensList[pieNames[i]]
    //       ?.map((e) => double.parse(e.amount))
    //       .toList()
    //       .sumOfDoublesInList,
    //   // title:
    //   // "${pieNames[i].capitialize}\n${categoryGroupedExpensList[pieNames[i]]?.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
    //   color: Colors.primaries[i],
    //   radius: 100,
    //   titleStyle: TextStyle(
    //       fontSize: AppFontSize.fontSize12,
    //       fontWeight: FontWeight.bold,
    //       color: const Color(0xffffffff)),
    // ));
  }
  // return PieChart(PieChartData(centerSpaceRadius: 30, sections: sections));
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.start,
    children: sections,
  );
}
