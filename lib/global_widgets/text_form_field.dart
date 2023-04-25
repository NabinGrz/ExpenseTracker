import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFormField(
    {required Widget icon,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? hintText,
    TextEditingController? controller,
    required Function(String) onChanged}) {
  return TextFormField(
    textInputAction: textInputAction ?? TextInputAction.next,
    keyboardType: keyboardType ?? TextInputType.name,
    controller: controller,
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r))),
    onChanged: onChanged,
  );
}
