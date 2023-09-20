import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/models/request/auth/profile_update_model.dart';
import 'package:job/services/helpers/auth_helpers.dart';
import 'package:job/views/ui/auth/update_user.dart';
import 'package:job/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/auth/login_model.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get isObscureText => _obscureText;

  set isObscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entryPoint;

  bool get entryPoint => _entryPoint ?? false;

  set entryPoint(bool newState) {
    _entryPoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entryPoint = prefs.getBool("entrypoint") ?? false;
    loggedIn = prefs.getBool("loggedIn") ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin(LoginModel model) {
    AuthHelper.login(model).then((response) => {
          if (response && firstTime)
            {Get.off(() => const PersonalDetails())}
          else if (response && !firstTime)
            {Get.off(() => const MainScreen())}
          else if (!response)
            {
              Get.snackbar("Sign Failed", "Please chech your credentials",
                  colorText: Color(kLight.value),
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.add_alert))
            }
        });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", false);
    await prefs.remove("token");
    _firstTime = false;
  }

  updateProfile(ProfileUpdateReq model) {
    AuthHelper.updateProfile(model).then((response) {
      if (response) {
        Get.snackbar(
          "Profile Updated",
          "Enjoy a search for a job",
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.add_alert),
        );
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar(
          "Update Failed",
          "Please Check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
