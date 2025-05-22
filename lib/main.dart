import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:expensetracker/core/theme/app_theme.dart';
import 'package:expensetracker/expense_tracker_app.dart';
import 'package:expensetracker/features/theme/bloc/theme_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart'; // No longer directly used here for theme
// import 'core/constants/app_colors.dart'; // No longer directly used here for theme

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance;
  FirebaseFirestore.instance;
  runApp(
    DevicePreview(
      enabled: false, // Or your existing condition
      builder: (context) => BlocProvider(
        create: (context) => ThemeBloc()..add(ThemeLoadStarted()),
        child: const MyApp(),
      ),
    ),
  );
}

// Future<void> initializeFirebase() async {} // This function was empty, can be removed if not used

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme, // Provide the light theme as default
          darkTheme: AppTheme.darkTheme, // Provide the dark theme
          themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Control actual theme mode
          home: ScreenUtilInit(
            builder: (context, child) {
              return const ExpenseTrackerApp();
            },
          ),
        );
      },
    );
  }
}
