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

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  bool _passwordMatch = true;
  bool get passwordMatch => _passwordMatch;

  String _message = '';
  String get message => _message;

  void changeVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void checkPasswordsMatch(String password, String confirmPassword) {
    _passwordMatch = password == confirmPassword;
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
