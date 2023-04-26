import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:expensetracker/expense_tracker_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance;
  FirebaseFirestore.instance;
  runApp(DevicePreview(
    enabled: false,
    builder: (context) {
      return const MyApp();
    },
  ));
}

Future<void> initializeFirebase() async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(indicatorColor: Colors.red),
        // useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light()
            .textTheme
            .copyWith(
              displayLarge:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              displayMedium:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              displaySmall: const TextStyle(fontSize: 16),
              titleMedium: const TextStyle(fontSize: 12), //MEDIUM TEXT
              bodySmall: const TextStyle(fontSize: 14),
              headlineSmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor),
              headlineMedium:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              labelLarge: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500),
              bodyLarge: const TextStyle(fontSize: 10), //MESSAGE
            )),
        primarySwatch: const MaterialColor(0XFF175C9D, <int, Color>{
          50: Color(0XFF175C9D),
          100: Color(0XFF175C9D),
          200: Color(0XFF175C9D),
          300: Color(0XFF175C9D),
          400: Color(0XFF175C9D),
          500: Color(0XFF175C9D),
          600: Color(0XFF175C9D),
          700: Color(0XFF175C9D),
          800: Color(0XFF175C9D),
          900: Color(0XFF175C9D),
        }),
      ),
      home: ScreenUtilInit(
        builder: (context, child) {
          return const ExpenseTrackerApp();
        },
      ),
    );
  }
}
