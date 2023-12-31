import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/models/request/auth/login_model.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/custom_btn.dart';
import 'package:job/views/common/custom_textfield.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/ui/auth/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      loginNotifier.getPrefs();
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Login",
              child: loginNotifier.entryPoint && loginNotifier.loggedIn
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(CupertinoIcons.arrow_left),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                const HeightSpacer(size: 50),
                ReusableText(
                    text: "Welcome",
                    style: appstyle(30, Color(kDark.value), FontWeight.w600)),
                ReusableText(
                    text: "Fill the details to login to your account",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                const HeightSpacer(size: 50),
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
                  hintText: "Email",
                  keyboardType: TextInputType.text,
                  obscureText: loginNotifier.isObscureText,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 7) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifier.isObscureText =
                          !loginNotifier.isObscureText;
                    },
                    child: Icon(
                      loginNotifier.isObscureText
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
                        text: "Registor",
                        style:
                            appstyle(14, Color(kDark.value), FontWeight.w500)),
                    onTap: () {
                      Get.to(() => const RegistrationPage());
                    },
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomButton(
                  text: "Login",
                  onTap: () {
                    if (loginNotifier.validateAndSave()) {
                      LoginModel model = LoginModel(
                          email: email.text, password: password.text);

                      loginNotifier.userLogin(model);
                    } else {
                      Get.snackbar(
                          "Sign Failed", "Please chech your credentials",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert));
                    }
                  },
                )
              ],
            ),
          ));
    });
  }
}
