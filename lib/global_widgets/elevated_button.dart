import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget elevatedButton(
    {required void Function()? onPressed,
    required Widget? child,
    Color? backgroundColor}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 35.h),
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor != null ? Colors.white : null),
    child: child,
  );
}
