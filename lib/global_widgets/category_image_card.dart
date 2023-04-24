import 'package:expensetracker/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color getCardColorByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return const Color.fromARGB(255, 255, 193, 189);
    case AppString.categoryClothing:
      return const Color.fromARGB(255, 181, 222, 255);
    case AppString.categoryRent:
      return const Color.fromARGB(255, 245, 188, 255);
    case AppString.categoryBike:
      return const Color.fromARGB(255, 254, 226, 184);
    case AppString.categoryTransport:
      return const Color.fromARGB(255, 255, 185, 208);
    case AppString.categoryUtils:
      return const Color.fromARGB(255, 182, 222, 255);
    default:
      return const Color.fromARGB(255, 199, 255, 201);
  }
}

Color getImageColorByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return Colors.red;
    case AppString.categoryClothing:
      return Colors.blue;
    case AppString.categoryRent:
      return Colors.purple;
    case AppString.categoryBike:
      return Colors.orange;
    case AppString.categoryTransport:
      return Colors.pink;
    case AppString.categoryUtils:
      return Colors.blue;
    default:
      return Colors.green;
  }
}

String getIconPathByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return "assets/icons/foodExpensesIcon.png";
    case AppString.categoryClothing:
      return "assets/icons/clothingExpensesIcon.png";
    case AppString.categoryRent:
      return "assets/icons/rentExpensesIcon.png";
    case AppString.categoryBike:
      return "assets/icons/bikeServiceExpensesIcon.png";
    case AppString.categoryTransport:
      return "assets/icons/transportExpensesIcon.png";
    case AppString.categoryUtils:
      return "assets/icons/utilsExpensesIcon.png";
    default:
      return "assets/icons/otherExpensesIcon.png";
  }
}

Widget imageCard({required String categoryName}) {
  return Card(
    color: getCardColorByCategory(categoryName),
    margin: EdgeInsets.zero,
    //"assets/icons/foodExpensesIcon.png",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(getIconPathByCategory(categoryName),
          height: 20.h, color: getImageColorByCategory(categoryName)),
    ),
  );
}
