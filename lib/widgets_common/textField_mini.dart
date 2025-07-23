import 'package:bmi_calculator/core/consts/colors.dart';
import 'package:bmi_calculator/core/consts/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFieldMini({
  double? height,
  double? width,
  final Function(String)? onChanged,
  final String? Function(String?)? validator,
  final TextEditingController? controller,
  final Widget? preFixIcon,
  final int? maxLine,
  final bool? readOnly,
  final TextInputAction? textInputAction,
  final TextInputType? keyBoardType,
  final IconButton? suffixIcon,
  final Function(String)? onFieldSubmitted,
  final bool? isMultiline,
  final TextAlign? textAlign,
  final List<TextInputFormatter>? inputFormatters,
  final String? prefixText,
  final String? suffixText,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      cursorHeight: 40,
      textInputAction: textInputAction,
      keyboardType: keyBoardType,
      maxLines: maxLine ?? 1,
      onSubmitted: onFieldSubmitted,
      textAlign: textAlign ?? TextAlign.center,
      inputFormatters: inputFormatters,
      cursorColor: blue,
      cursorWidth: 3,
      style: const TextStyle(
        color: blue,
        fontSize: 30,
      ),
      decoration: InputDecoration(
        prefixIcon: preFixIcon,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        suffixText: suffixText,
        suffixStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: blue,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blue),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blue),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: blue),
        ),
      ),
    ),
  );
}

