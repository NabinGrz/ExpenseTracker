import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Keep constructor private if not needed

  // Common Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  // Consider adding other common colors if frequently used directly

  // Light Theme
  static Color primaryColor = const Color(0XFF175C9D); // Existing one
  static Color primaryColorLight = const Color(0XFF175C9D);
  static Color backgroundColorLight = Colors.white;
  static Color surfaceColorLight = Colors.white; // Or Colors.grey[50] for slight differentiation
  static Color textColorLight = Colors.black;
  static Color secondaryTextColorLight = Colors.grey[600]!; // Adjust as needed
  static Color appBarColorLight = primaryColorLight; // Often same as primary
  static Color scaffoldBackgroundColorLight = Colors.white;
  static Color errorColorLight = Colors.red;
  static Color borderColorLight = Colors.grey[300]!;

  // Dark Theme
  static Color primaryColorDark = const Color(0xFF2188FF); // Lighter blue for dark theme
  static Color backgroundColorDark = const Color(0xFF121212);
  static Color surfaceColorDark = const Color(0xFF1E1E1E);
  static Color textColorDark = Colors.white; // Or Color(0xFFE0E0E0)
  static Color secondaryTextColorDark = Colors.grey[400]!; // Or Color(0xFFA0A0A0)
  static Color appBarColorDark = const Color(0xFF1F1F1F);
  static Color scaffoldBackgroundColorDark = const Color(0xFF121212);
  static Color errorColorDark = Colors.redAccent[200]!;
  static Color borderColorDark = Colors.grey[700]!;

  // Category Colors - Light Variants
  static const Color categoryFoodLight = Color.fromARGB(255, 189, 255, 236);
  static const Color categoryClothingLight = Color.fromARGB(255, 181, 218, 255);
  static const Color categoryRentLight = Color.fromARGB(255, 255, 188, 188); // Also for Meat
  static const Color categoryBikeLight = Color.fromARGB(255, 254, 226, 184);
  static const Color categoryTransportLight = Color.fromARGB(255, 255, 185, 208);
  static const Color categoryUtilsLight = Color.fromARGB(255, 182, 222, 255);
  static const Color categoryKhajaLight = Color.fromARGB(255, 197, 182, 255);
  static const Color categoryMilkLight = Color.fromARGB(255, 182, 243, 255);
  static const Color categoryWaterLight = Color.fromARGB(255, 255, 236, 182);
  static const Color categoryGroceryLight = Color.fromARGB(255, 173, 168, 255);
  static const Color categoryChocolateLight = Color.fromARGB(255, 205, 204, 204);
  static const Color categoryStationaryLight = Color.fromARGB(255, 255, 182, 253);
  static const Color categoryFruitsLight = Color.fromARGB(255, 255, 223, 182);
  static const Color categoryCosmeticLight = Color.fromARGB(255, 244, 255, 182);
  static const Color categoryDefaultLight = Color.fromARGB(255, 199, 255, 201);

  // Category Colors - Dark Variants
  // These are chosen to be darker and less saturated, suitable for dark backgrounds.
  static const Color categoryFoodDark = Color.fromARGB(255, 20, 80, 60); // Dark Teal
  static const Color categoryClothingDark = Color.fromARGB(255, 30, 60, 90); // Dark Blue
  static const Color categoryRentDark = Color.fromARGB(255, 90, 40, 40); // Dark Red (Also for Meat)
  static const Color categoryBikeDark = Color.fromARGB(255, 90, 70, 40); // Dark Orange/Brown
  static const Color categoryTransportDark = Color.fromARGB(255, 90, 40, 60); // Dark Pink/Maroon
  static const Color categoryUtilsDark = Color.fromARGB(255, 30, 70, 90);    // Dark Sky Blue
  static const Color categoryKhajaDark = Color.fromARGB(255, 50, 30, 90);    // Dark Purple
  static const Color categoryMilkDark = Color.fromARGB(255, 30, 80, 90);     // Dark Cyan
  static const Color categoryWaterDark = Color.fromARGB(255, 90, 80, 30);    // Dark Yellow/Ochre
  static const Color categoryGroceryDark = Color.fromARGB(255, 40, 30, 90);   // Dark Indigo
  static const Color categoryChocolateDark = Color.fromARGB(255, 60, 60, 60); // Dark Grey
  static const Color categoryStationaryDark = Color.fromARGB(255, 80, 30, 90); // Dark Magenta
  static const Color categoryFruitsDark = Color.fromARGB(255, 90, 70, 50);   // Dark Orange/Brown
  static const Color categoryCosmeticDark = Color.fromARGB(255, 70, 90, 30);  // Dark Lime Green
  static const Color categoryDefaultDark = Color.fromARGB(255, 40, 80, 50);  // Dark Green
}
