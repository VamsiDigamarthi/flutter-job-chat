import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/models/request/auth/profile_update_model.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/custom_btn.dart';
import 'package:job/views/common/custom_textfield.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController(text: profile[0]);
  TextEditingController skill1 = TextEditingController(text: profile[1]);
  TextEditingController skill2 = TextEditingController(text: profile[2]);
  TextEditingController skill3 = TextEditingController(text: profile[3]);
  TextEditingController skill4 = TextEditingController(text: profile[4]);

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: "Update Profile",
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            )),
      ),
      body: Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                    text: "Personal Details",
                    style: appstyle(35, Color(kDark.value), FontWeight.w500)),
                Consumer<ImageUploader>(
                    builder: (context, imageUploader, child) {
                  return imageUploader.imageFil.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            imageUploader.pickImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(kLightBlue.value),
                            child: const Center(
                              child: Icon(Icons.photo_filter_rounded),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            imageUploader.imageFil.clear();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(kLightBlue.value),
                            backgroundImage:
                                FileImage(File(imageUploader.imageFil[0])),
                          ),
                        );
                })
              ],
            ),
            const HeightSpacer(size: 20),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeTextFiels(
                  controller: location,
                  hintText: "Location",
                  keyboardType: TextInputType.text,
                  validator: (location) {
                    if (location!.isEmpty) {
                      return "Please enter a valid location";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: phone,
                  hintText: "phone",
                  keyboardType: TextInputType.phone,
                  validator: (phone) {
                    if (phone!.isEmpty) {
                      return "Please enter a valid phone";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                ReusableText(
                    text: "Skills",
                    style: appstyle(30, Color(kDark.value), FontWeight.bold)),
                //
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: skill0,
                  hintText: "proffessional Skills",
                  keyboardType: TextInputType.text,
                  validator: (phone) {
                    if (phone!.isEmpty) {
                      return "Please enter a valid skils";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: skill1,
                  hintText: "proffessional Skills",
                  keyboardType: TextInputType.text,
                  validator: (skill1) {
                    if (skill1!.isEmpty) {
                      return "Please enter a valid skils";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: skill2,
                  hintText: "proffessional Skills",
                  keyboardType: TextInputType.text,
                  validator: (skill2) {
                    if (skill2!.isEmpty) {
                      return "Please enter a valid skils";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: skill3,
                  hintText: "proffessional Skills",
                  keyboardType: TextInputType.text,
                  validator: (skill3) {
                    if (skill3!.isEmpty) {
                      return "Please enter a valid skils";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 10),
                CustomeTextFiels(
                  controller: skill4,
                  hintText: "proffessional Skills",
                  keyboardType: TextInputType.text,
                  validator: (skill4) {
                    if (skill4!.isEmpty) {
                      return "Please enter a valid skils";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                Consumer<ImageUploader>(
                    builder: (context, imageUploader, child) {
                  return CustomButton(
                    text: "Update Profile",
                    onTap: () {
                      if (imageUploader.imageFil.isEmpty &&
                          imageUploader.imageUrl == null) {
                        Get.snackbar(
                          "Image Missing",
                          "Please upload an image to proceed",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert),
                        );
                      } else {
                        if (loginNotifier.profileValidation()) {
                          // print("reached here 2");
                          ProfileUpdateReq model = ProfileUpdateReq(
                            location: location.text,
                            phone: phone.text,
                            profile: imageUploader.imageUrl.toString(),
                            skills: [
                              skill0.text,
                              skill1.text,
                              skill2.text,
                              skill3.text,
                              skill4.text,
                            ],
                          );

                          loginNotifier.updateProfile(model);
                        } else {
                          Get.snackbar(
                            "Profile Update Failed",
                            "Please Check your credentials",
                            colorText: Color(kLight.value),
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.add_alert),
                          );
                        }
                      }
                    },
                  );
                }),
              ],
            ))
          ],
        );
      }),
    );
  }
}
