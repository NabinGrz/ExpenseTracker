import 'package:flutter/material.dart';

Widget textFormField(
    {required Icon icon,
    required TextEditingController controller,
    required Function(String) onChanged}) {
  return TextFormField(
    controller: controller,
    decoration:
        InputDecoration(prefixIcon: icon, border: const OutlineInputBorder()),
    onChanged: onChanged,
  );
}
