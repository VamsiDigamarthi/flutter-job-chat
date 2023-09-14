

import 'package:flutter/material.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/custom_outline_btn.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';

import 'package:get/get.dart';
import 'package:job/views/ui/auth/login.dart';





class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kLightBlue.value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                CustomOulineBtn(
                  onTap: (){
                    Get.to(() => const LoginPage());
                  },
                  width: width*0.4, 
                  height: hieght*0.06, 
                  text: "Login", 
                  color: Color(kLight.value)
                ),
                 GestureDetector(
                  onTap: null,
                  child: Container(
                     width: width*0.4, 
                     height: hieght*0.06, 
                     color: Color(kLight.value),
                     child: Center(child: ReusableText(text: "sign up", style: appstyle(16, Color(kLightBlue.value), FontWeight.w600))),
                  ),
                 )
              ],
            ),
            const HeightSpacer(size: 30),

            ReusableText(text: "Continue as guest", style: appstyle(16, Color(kLight.value), FontWeight.w400))
          ],
        ),
      ),
    );
  }
}