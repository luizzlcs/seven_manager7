
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {

  bool _isVisible = false;

  bool get isVisible => _isVisible;
  
  void changeVisible(){
    _isVisible = !_isVisible;
    notifyListeners();
    print(_isVisible);
  }
  
}