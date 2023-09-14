
import 'package:flutter/material.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/reusable_text.dart';

class CustomOulineBtn extends StatelessWidget {
  const CustomOulineBtn({super.key, required this.width, required this.height, required this.text, this.onTap, required this.color, this.color1});

  final double? width;

  final double? height;

  final String text;

  final void Function()? onTap;

  final Color color;

  final Color? color1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color1,
          border: Border.all(
            width: 1,
            color: color
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6))
        ),
        child: Center(
          child: ReusableText(text: text, style: appstyle(16, color, FontWeight.w600)),
        ),
      )
    );
  }
}