import 'package:expensetracker/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

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

Color? getImageColorByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return null;
    case AppString.categoryClothing:
      return null;
    case AppString.categoryRent:
      return null;
    case AppString.categoryBike:
      return null;
    case AppString.categoryTransport:
      return null;
    case AppString.categoryUtils:
      return null;
    default:
      return null;
  }
}

String getIconPathByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return "assets/icons/food.png";
    case AppString.categoryClothing:
      return "assets/icons/clothing.png";
    case AppString.categoryRent:
      return "assets/icons/rent.png";
    case AppString.categoryBike:
      return "assets/icons/bike.png";
    case AppString.categoryTransport:
      return "assets/icons/transport.png";
    case AppString.categoryUtils:
      return "assets/icons/utils.png";
    default:
      return "assets/icons/bill.png";
  }
}

Widget categoryImageCard({required String categoryName}) {
  return Card(
    color: getCardColorByCategory(categoryName),
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(getIconPathByCategory(categoryName),
          fit: BoxFit.contain,
          // height: 30.h,
          color: getImageColorByCategory(categoryName)),
    ),
  );
}
