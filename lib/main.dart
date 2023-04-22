import 'package:cloud_firestore/cloud_firestore.dart';
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
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: const MaterialColor(0XFF175C9D, <int, Color>{
          50: Color(0XFF175C9D), //10%
          100: Color(0XFF175C9D), //20%
          200: Color(0XFF175C9D), //30%
          300: Color(0XFF175C9D), //40%
          400: Color(0XFF175C9D), //50%
          500: Color(0XFF175C9D), //60%
          600: Color(0XFF175C9D), //70%
          700: Color(0XFF175C9D), //80%
          800: Color(0XFF175C9D), //90%
          900: Color(0XFF175C9D), //100% 10%
        }),
        // primarySwatch: const MaterialColor(0XFF175C9D, <int, Color>{
        //   50: Color(0xffce5641), //10%
        //   100: Color(0xffb74c3a), //20%
        //   200: Color(0xffa04332), //30%
        //   300: Color(0xff89392b), //40%
        //   400: Color(0xff733024), //50%
        //   500: Color(0xff5c261d), //60%
        //   600: Color(0xff451c16), //70%
        //   700: Color(0xff2e130e), //80%
        //   800: Color(0xff170907), //90%
        //   900: Color(0xff000000), //100% 10%
        // }),
      ),
      home: ScreenUtilInit(
        builder: (context, child) {
          return const ExpenseTrackerApp();
        },
      ),
    );
  }
}
