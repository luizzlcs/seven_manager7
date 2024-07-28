import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error;
}

class RegisterController with ChangeNotifier {
  RegisterController({
    required this.firebaseAuth,
  });

  final FirebaseAuthService firebaseAuth;

  RegisterStatus _registerStatus = RegisterStatus.initial;
  RegisterStatus get registerStatus => _registerStatus;

  bool isVisible = false;
  bool passwordMatch = true;
  String _message = '';
  String get message => _message;

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
    _registerStatus = RegisterStatus.loading;
    notifyListeners();
    final String? auth = await firebaseAuth.createUser(
        name: name, email: email, password: password);

    if (auth == null) {
      _message = 'Usuário criado com sucesso!';
      notifyListeners();
      _registerStatus = RegisterStatus.success;
      notifyListeners();
    } else {
      _message = auth;
      _registerStatus = RegisterStatus.error;
      notifyListeners();
    }
  }
}
