import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/common/width_spacer.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: hieght * 0.15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(kLightGrey.value),
                        radius: 30,
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: "DBtest",
                              style: appstyle(
                                  20, Color(kDark.value), FontWeight.w600)),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                                text: "Django Developer",
                                style: appstyle(
                                    20, Color(kDark.value), FontWeight.w600)),
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: const Icon(Ionicons.chevron_forward),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    ReusableText(
                        text: "20k",
                        style:
                            appstyle(23, Color(kDark.value), FontWeight.w600)),
                    ReusableText(
                        text: "/monthly",
                        style: appstyle(
                            23, Color(kDarkGrey.value), FontWeight.w600)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
