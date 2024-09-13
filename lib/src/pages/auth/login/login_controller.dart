import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';

enum LoginStatus { initial, loading, success, error }

class LoginController with ChangeNotifier {
  LoginController({required this.firebaseAuth});

  final AuthServiceFirebaseImpl firebaseAuth;

  LoginStatus loginStatus = LoginStatus.initial;
  bool isVisible = false;
  
  String? _message;
  String? get message => _message;

  void changeVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    loginStatus = LoginStatus.loading;
    notifyListeners();
    final String? auth =
        await firebaseAuth.signInWithEmail(email: email, password: password);

    if (auth == null) {
      loginStatus = LoginStatus.success;
      _message = 'Você logou com $email';
      notifyListeners();
      _message = '';
      loginStatus = LoginStatus.initial;
    } else {
      _message = auth;
      loginStatus = LoginStatus.error;
      notifyListeners();
    }
  }
}
