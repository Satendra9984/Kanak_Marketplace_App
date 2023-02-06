import 'package:flutter/material.dart';

import 'app_constants.dart';

InputDecoration getInputDecoration(String hintText) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: accent1),
    ),
    errorStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    filled: true,
    fillColor: text100,
  );
}
