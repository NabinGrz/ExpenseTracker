import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget elevatedButton(
    {required void Function()? onPressed, required Widget? child}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 35.h)),
    child: child,
  );
}
