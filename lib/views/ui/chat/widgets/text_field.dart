import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';

class MessaginTextField extends StatelessWidget {
  const MessaginTextField({
    super.key,
    required this.messageController,
    required this.suffixIcon,
    required this.onChange,
    this.onEditingComplete,
    this.onTapOutside,
    this.onSubmitted,
  });

  final TextEditingController messageController;

  final Widget suffixIcon;

  final void Function(String?) onChange;

  final void Function()? onEditingComplete;

  final void Function(PointerDownEvent)? onTapOutside;

  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      cursorColor: Color(kDarkGrey.value),
      keyboardType: TextInputType.multiline,
      style: appstyle(16, Color(kDark.value), FontWeight.w500),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(16.h),
        filled: true,
        fillColor: Color(kLight.value),
        suffixIcon: suffixIcon,
        hintText: "Type your message here",
        hintStyle: appstyle(14, Color(kDarkGrey.value), FontWeight.normal),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kLightGrey.value))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kLightGrey.value))),
      ),
      onChanged: onChange,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
