import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:expensetracker/expense_tracker_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
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
