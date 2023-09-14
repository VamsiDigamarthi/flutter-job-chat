

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        // color: Color(kLightPurple.value),
        color:Colors.black,
        child: Column(
          children: [
           const HeightSpacer(size: 60,),
            Image.asset("assets/images/smoke-3352138_1280-removebg-preview.png",height: 500.0,),
            const HeightSpacer(size: 30,),
            Column(
              children: [
                ReusableText(text: "Find your dream job", style: appstyle(20, Color(kOrange.value), FontWeight.bold)),
                const HeightSpacer(size: 10),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal : 30.0.w),
                  child: Text(
                    textAlign : TextAlign.center,
                    "we help you find dream job according to your skills there have also been dubious psychometric tests and other horrors to contend with, and now we", 
                    style: appstyle(14, Color(kLight.value), FontWeight.normal)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}