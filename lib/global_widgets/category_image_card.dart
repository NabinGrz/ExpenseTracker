import 'package:expensetracker/core/constants/app_colors.dart';
import 'package:expensetracker/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

Color getCardColorByCategory(BuildContext context, String categoryName) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  switch (categoryName.toLowerCase()) {
    case AppString.categoryFood:
      return isDarkMode ? AppColors.categoryFoodDark : AppColors.categoryFoodLight;
    case AppString.categoryClothing:
      return isDarkMode ? AppColors.categoryClothingDark : AppColors.categoryClothingLight;
    case AppString.categoryRent:
      return isDarkMode ? AppColors.categoryRentDark : AppColors.categoryRentLight;
    case AppString.categoryBike:
      return isDarkMode ? AppColors.categoryBikeDark : AppColors.categoryBikeLight;
    case AppString.categoryTransport:
      return isDarkMode ? AppColors.categoryTransportDark : AppColors.categoryTransportLight;
    case AppString.categoryUtils:
      return isDarkMode ? AppColors.categoryUtilsDark : AppColors.categoryUtilsLight;
    case AppString.categoryKhaja:
      return isDarkMode ? AppColors.categoryKhajaDark : AppColors.categoryKhajaLight;
    case AppString.categoryMilk:
      return isDarkMode ? AppColors.categoryMilkDark : AppColors.categoryMilkLight;
    case AppString.categoryWater:
      return isDarkMode ? AppColors.categoryWaterDark : AppColors.categoryWaterLight;
    case AppString.categoryGrocery:
      return isDarkMode ? AppColors.categoryGroceryDark : AppColors.categoryGroceryLight;
    case AppString.categoryChocolate:
      return isDarkMode ? AppColors.categoryChocolateDark : AppColors.categoryChocolateLight;
    case AppString.categoryMeat: // Uses the same colors as Rent
      return isDarkMode ? AppColors.categoryRentDark : AppColors.categoryRentLight;
    case AppString.categoryStationary:
      return isDarkMode ? AppColors.categoryStationaryDark : AppColors.categoryStationaryLight;
    case AppString.categoryFruits:
      return isDarkMode ? AppColors.categoryFruitsDark : AppColors.categoryFruitsLight;
    case AppString.categoryCosmetic:
      return isDarkMode ? AppColors.categoryCosmeticDark : AppColors.categoryCosmeticLight;
    default:
      return isDarkMode ? AppColors.categoryDefaultDark : AppColors.categoryDefaultLight;
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

Widget categoryImageCard({required BuildContext context, required String categoryName}) {
  return Card(
    color: getCardColorByCategory(context, categoryName), // Pass context
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
