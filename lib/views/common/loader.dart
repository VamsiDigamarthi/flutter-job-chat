import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/reusable_text.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        children: [
          Image.asset("assets/images/search_cart.png"),
          ReusableText(
              text: text,
              style: appstyle(24, Color(kDark.value), FontWeight.bold)),
        ],
      ),
    );
  }
}
