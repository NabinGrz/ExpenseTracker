import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expensetracker/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._(); // Private constructor

  // Helper function to create a MaterialColor from a single Color
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColorLight,
    primarySwatch: _createMaterialColor(AppColors.primaryColorLight),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorLight,
    appBarTheme: AppBarTheme(
      color: AppColors.appBarColorLight,
      iconTheme: IconThemeData(color: AppColors.white), // Assuming icons on AppBar are white
      toolbarTextStyle: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).bodyMedium?.copyWith(color: AppColors.white),
      titleTextStyle: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).titleLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.primaryColorLight, // Using primary as secondary for now
      error: AppColors.errorColorLight,
      background: AppColors.backgroundColorLight,
      surface: AppColors.surfaceColorLight,
      onPrimary: AppColors.white, // Text/icon color on primary color
      onSecondary: AppColors.white, // Text/icon color on secondary color
      onBackground: AppColors.textColorLight,
      onSurface: AppColors.textColorLight,
      onError: AppColors.white, // Text/icon color on error color
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme.copyWith(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColorLight),
      displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColorLight),
      displaySmall: TextStyle(fontSize: 16, color: AppColors.textColorLight),
      headlineMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textColorLight), // headline4
      headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColorLight), // headline5, used in main.dart
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textColorLight), // headline6
      titleMedium: TextStyle(fontSize: 12, color: AppColors.textColorLight), // subtitle1, used in main.dart for MEDIUM TEXT
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textColorLight), // subtitle2
      bodyLarge: TextStyle(fontSize: 10, color: AppColors.textColorLight), // bodyText1, used in main.dart for MESSAGE
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textColorLight), // bodyText2, default for Text widget
      bodySmall: TextStyle(fontSize: 14, color: AppColors.textColorLight), // caption, used in main.dart
      labelLarge: TextStyle(fontSize: 14, letterSpacing: 0.5, fontWeight: FontWeight.w500, color: AppColors.textColorLight), // button
      labelSmall: TextStyle(fontSize: 10, letterSpacing: 0.5, color: AppColors.textColorLight), // overline
    )),
    tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.red, // From main.dart
        labelColor: AppColors.primaryColorLight,
        unselectedLabelColor: AppColors.secondaryTextColorLight,
      ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorDark,
    primarySwatch: _createMaterialColor(AppColors.primaryColorDark),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorDark,
    appBarTheme: AppBarTheme(
      color: AppColors.appBarColorDark,
      iconTheme: IconThemeData(color: AppColors.textColorDark),
      toolbarTextStyle: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).bodyMedium?.copyWith(color: AppColors.textColorDark),
      titleTextStyle: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).titleLarge?.copyWith(color: AppColors.textColorDark, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.primaryColorDark, // Using primary as secondary for now
      error: AppColors.errorColorDark,
      background: AppColors.backgroundColorDark,
      surface: AppColors.surfaceColorDark,
      onPrimary: AppColors.textColorDark, // Text/icon color on primary color
      onSecondary: AppColors.textColorDark, // Text/icon color on secondary color
      onBackground: AppColors.textColorDark,
      onSurface: AppColors.textColorDark,
      onError: AppColors.black, // Text/icon color on error color (often dark for dark themes)
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme.copyWith(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColorDark),
      displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColorDark),
      displaySmall: TextStyle(fontSize: 16, color: AppColors.textColorDark),
      headlineMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textColorDark),
      headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColorDark), // Match light's accent
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textColorDark),
      titleMedium: TextStyle(fontSize: 12, color: AppColors.textColorDark),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textColorDark),
      bodyLarge: TextStyle(fontSize: 10, color: AppColors.textColorDark),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textColorDark),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.textColorDark),
      labelLarge: TextStyle(fontSize: 14, letterSpacing: 0.5, fontWeight: FontWeight.w500, color: AppColors.textColorDark),
      labelSmall: TextStyle(fontSize: 10, letterSpacing: 0.5, color: AppColors.textColorDark),
    )),
     tabBarTheme: TabBarTheme(
        indicatorColor: Colors.redAccent, // A slightly brighter red for dark theme
        labelColor: AppColors.primaryColorDark,
        unselectedLabelColor: AppColors.secondaryTextColorDark,
      ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
