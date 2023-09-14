


import 'package:flutter/material.dart';

class SignupNotifier extends ChangeNotifier{
 bool _obscureText = true;

  bool get isObscureText => _obscureText;

  set isObscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }
  
  bool passwordValidator(String password){
    if(password.isEmpty) return false;
    String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&-+=()])(?=\\S+$).{8, 20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

}