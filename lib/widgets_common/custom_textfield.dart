import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/consts/colors.dart';
import '../core/consts/styles.dart';

Widget customTextfield({
  required String? hint,
   double? height,
  required double? width,
})
{ return SizedBox(
  height: height,
  width: width,
  child: TextField(

    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: medium,
        fontSize: 15,
        color: fontGrey,
      ),
      filled: true,
      fillColor: Colors.white70,
      border: OutlineInputBorder(),
    ),
  ),
);}



class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final initialValue;
  final enabled;
  final controller;
  final preFixIcon;
  final maxLine;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final bool readOnly;
  final textInputAction;
  final keyBoardType;
  final IconButton? suffixIcon;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final bool isMultiline;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;

  CustomTextField({

    this.isMultiline = false,
    this.preFixIcon,
    this.maxLine = 1,
    this.readOnly = false,
    this.autofillHints,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyBoardType,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    EdgeInsets? contentPadding,
    this.textAlign = TextAlign.center,
    this.inputFormatters,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: textInputAction??TextInputAction.next,
      readOnly: readOnly,
      keyboardType: keyBoardType,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      maxLines: maxLine,
      obscureText: obscureText,
      autofillHints: autofillHints,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600
      ),
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      // textAlign: textAlign,
      decoration: InputDecoration(
          filled: true,
          enabled: enabled,
          prefixText: prefixText,
          fillColor: Colors.white70,
          hintText: hintText,
          border: InputBorder.none,
          prefixStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelStyle: const TextStyle( fontSize: 14,
              fontWeight: FontWeight.w400),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 25, vertical: 10),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: borderColor, width: 1),
            borderSide: const BorderSide(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle:  const TextStyle(fontSize: 14, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkFontGrey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffF7658B), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffF7658B), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xffF7658B),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: preFixIcon
      ),
    );
  }
}