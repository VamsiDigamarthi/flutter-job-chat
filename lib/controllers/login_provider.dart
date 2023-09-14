
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier{

  bool _obscureText = true;

  bool get isObscureText => _obscureText;

  set isObscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }
  
}