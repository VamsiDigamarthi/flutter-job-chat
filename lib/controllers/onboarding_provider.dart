

import 'package:flutter/material.dart';

class OnBoardNotfier extends ChangeNotifier{
  bool _isLastPage = false;
  
  bool get isLastPage => _isLastPage;

  set isLastPage(bool lastpage){
    _isLastPage = lastpage;
    notifyListeners();
  }

}