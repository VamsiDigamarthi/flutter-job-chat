import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:job/constants/app_constants.dart';
import 'package:job/models/request/auth/signup_model.dart';
import 'package:job/services/helpers/auth_helpers.dart';
import 'package:job/views/ui/auth/login.dart';

class SignupNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get isObscureText => _obscureText;

  set isObscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&-+=()])(?=\\S+$).{8, 20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  upSignup(SignupModel model) {
    AuthHelper.signup(model).then((response) => {
          if (response)
            {
              Get.off(() => const LoginPage(),
                  transition: Transition.fade,
                  duration: const Duration(seconds: 2))
            }
          else
            {
              Get.snackbar("Sign up Failed", "Please chech your credentials",
                  colorText: Color(kLight.value),
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.add_alert))
            }
        });
  }
}
