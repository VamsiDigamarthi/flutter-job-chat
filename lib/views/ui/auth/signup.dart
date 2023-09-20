import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/controllers/signup_provider.dart';
import 'package:job/models/request/auth/signup_model.dart';
import 'package:job/views/common/custom_btn.dart';
import 'package:job/views/common/custom_textfield.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:provider/provider.dart';
import 'package:job/views/ui/auth/login.dart';

import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var logginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignupNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Signup",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: signupNotifier.signupFormKey,
              child: ListView(
                children: [
                  const HeightSpacer(size: 50),
                  ReusableText(
                      text: "Hello, Welcome ",
                      style: appstyle(30, Color(kDark.value), FontWeight.w600)),
                  ReusableText(
                      text: "Fill the details to signup to your account",
                      style: appstyle(
                          16, Color(kDarkGrey.value), FontWeight.w600)),
                  const HeightSpacer(size: 50),
                  CustomeTextFiels(
                    controller: name,
                    hintText: "Email",
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomeTextFiels(
                    controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomeTextFiels(
                    controller: password,
                    hintText: "passworod",
                    keyboardType: TextInputType.text,
                    obscureText: signupNotifier.isObscureText,
                    validator: (password) {
                      if (signupNotifier.passwordValidator(password ?? "")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signupNotifier.isObscureText =
                            !signupNotifier.isObscureText;
                      },
                      child: Icon(
                        signupNotifier.isObscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: ReusableText(
                          text: "Login",
                          style: appstyle(
                              14, Color(kDark.value), FontWeight.w500)),
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomButton(
                    text: "Signup",
                    onTap: () {
                      if (signupNotifier.validateAndSave()) {
                        SignupModel model = SignupModel(
                            username: name.text,
                            email: email.text,
                            password: password.text);
                        signupNotifier.upSignup(model);
                        logginNotifier.firstTime = !logginNotifier.firstTime;
                      } else {
                        Get.snackbar(
                            "Sign up Failed", "Please chech your credentials",
                            colorText: Color(kLight.value),
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.add_alert));
                      }
                    },
                  )
                ],
              ),
            ),
          ));
    });
  }
}
