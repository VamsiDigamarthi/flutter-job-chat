import 'package:flutter/material.dart';
import 'package:job/views/common/app_style.dart';

import '../../constants/app_constants.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.onEditingComplete,
      this.obscureText});

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  final Widget? suffixIcon;
  final void Function()? onEditingComplete;

  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(kLightGrey.value),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
            hintText: hintText.toUpperCase(),
            suffixIcon: suffixIcon,
            suffixIconColor: Color(kLight.value),
            hintStyle: appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.white, width: 0.5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey, width: 0.5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.5)),
            border: InputBorder.none),
        controller: controller,
        cursorHeight: 25,

        style: appstyle(14, Color(kDark.value), FontWeight.w500),
        // validator:validator,
      ),
    );
  }
}
