import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFormField({
  required Widget icon,
  Widget? suffixIcon,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  String? hintText,
  TextEditingController? controller,
  required Function(String) onChanged,
  void Function()? onClear,
}) {
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
        suffixIcon: InkWell(
          onTap: onClear ??
              () {
                controller?.clear();
              },
          child: Icon(
            CupertinoIcons.clear,
            size: 15.h,
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r))),
    onChanged: onChanged,
  );
}
