
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/common/width_spacer.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width*0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Feather.search, color: Color(kOrange.value), size: 20.h,),
                    const WidthSpacer(width: 20),
                    ReusableText(text: "Search for job",
                     style: appstyle(18, Color(kOrange.value), FontWeight.w500))
                  ],
                ),
              ),
              Icon(FontAwesome.sliders, color: Color(kDarkGrey.value), size: 20.h,)
            ],
          ),
          const HeightSpacer(size: 7),
          Divider(color: Color(kDarkGrey.value),
            endIndent: 40.w,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}