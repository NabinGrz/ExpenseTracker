import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_styles.dart';

Widget noExpenseFoundWidget(bool isFilterTab) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Image.asset(
        "assets/icons/expense.png",
        color: Colors.grey,
        height: 140.h,
      ),
      Text(
        "No Expenses Found!!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: AppFontSize.fontSize16,
        ),
      ),
      if (isFilterTab)
        Text(
          "Try changing date from filter option",
          style: TextStyle(
            color: Colors.grey,
            fontSize: AppFontSize.fontSize14,
          ),
        ),
    ],
  ));
}
