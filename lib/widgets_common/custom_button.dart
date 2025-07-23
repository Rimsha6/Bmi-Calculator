import 'package:bmi_calculator/core/consts/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget customButton({
  String? title,
  required VoidCallback? onPressed,
  required Color color,
  required Color textColor,
  required double width,
  required double height,
  Widget? child,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      ),
      child: child ??
          (title != null
              ? Text(title,
            style: TextStyle(
              fontFamily: medium,
              fontSize: 19,
              color: textColor,
            ),
          )
              : const SizedBox()),
    ),
  );
}