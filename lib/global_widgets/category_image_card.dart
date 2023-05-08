import 'package:expensetracker/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

Color getCardColorByCategory(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return const Color.fromARGB(255, 189, 255, 236);
    case AppString.categoryClothing:
      return const Color.fromARGB(255, 181, 218, 255);
    case AppString.categoryRent:
      return const Color.fromARGB(255, 255, 188, 188);
    case AppString.categoryBike:
      return const Color.fromARGB(255, 254, 226, 184);
    case AppString.categoryTransport:
      return const Color.fromARGB(255, 255, 185, 208);
    case AppString.categoryUtils:
      return const Color.fromARGB(255, 182, 222, 255);
    case AppString.categoryKhaja:
      return const Color.fromARGB(255, 197, 182, 255);
    case AppString.categoryMilk:
      return const Color.fromARGB(255, 182, 243, 255);
    case AppString.categoryWater:
      return const Color.fromARGB(255, 255, 236, 182);
    case AppString.categoryGrocery:
      return const Color.fromARGB(255, 173, 168, 255);
    case AppString.categoryChocolate:
      return const Color.fromARGB(255, 205, 204, 204);
    case AppString.categoryMeat:
      return const Color.fromARGB(255, 255, 182, 182);
    case AppString.categoryStationary:
      return const Color.fromARGB(255, 255, 182, 253);
    case AppString.categoryFruits:
      return const Color.fromARGB(255, 255, 223, 182);
    case AppString.categoryCosmetic:
      return const Color.fromARGB(255, 244, 255, 182);
    default:
      return const Color.fromARGB(255, 199, 255, 201);
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
    case AppString.categoryKhaja:
      return "assets/icons/khaja.png";
    case AppString.categoryMilk:
      return "assets/icons/milk.png";
    case AppString.categoryWater:
      return "assets/icons/water.png";
    case AppString.categoryGrocery:
      return "assets/icons/grocery.png";
    case AppString.categoryChocolate:
      return "assets/icons/chocolate.png";
    case AppString.categoryMeat:
      return "assets/icons/meat.png";
    case AppString.categoryFruits:
      return "assets/icons/fruits.png";
    case AppString.categoryStationary:
      return "assets/icons/stationary.png";
    case AppString.categoryCosmetic:
      return "assets/icons/cosmetic.png";
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
      child: Image.asset(
        getIconPathByCategory(categoryName),
        fit: BoxFit.contain,
      ),
    ),
  );
}
