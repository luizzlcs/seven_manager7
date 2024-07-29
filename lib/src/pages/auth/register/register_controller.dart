import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterController with ChangeNotifier {
  RegisterController({required this.firebaseAuth});

  final FirebaseAuthService firebaseAuth;

  RegisterStatus registerStatus = RegisterStatus.initial;
  bool isVisible = false;
  bool passwordMatch = true;
  String message = '';

  void changeVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void checkPasswordsMatch(String password, String confirmPassword) {
    passwordMatch = password == confirmPassword;
    notifyListeners();
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    registerStatus = RegisterStatus.loading;
    notifyListeners();
    final String? auth = await firebaseAuth.createUser(
        name: name, email: email, password: password);

    if (auth == null) {
      message = 'Você logu pela 1ª vez com $email';
      notifyListeners();
      registerStatus = RegisterStatus.success;
      notifyListeners();
    } else {
      message = auth;
      registerStatus = RegisterStatus.error;
      notifyListeners();
    }
  }
}
