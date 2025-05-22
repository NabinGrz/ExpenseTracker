import 'package:flutter/material.dart';

Widget sizedBox({double? height, double? width, Widget? child}) {
  return SizedBox(
    height: height,
    width: width,
    child: child,
  );
}
