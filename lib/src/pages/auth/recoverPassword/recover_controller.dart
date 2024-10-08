import 'package:flutter/material.dart';

import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';

enum RecoverStatus { initial, loading, success, error }

class RecoverController with ChangeNotifier {
  RecoverController({required this.firebaseAuth});

  final AuthServiceFirebaseImpl firebaseAuth;

  RecoverStatus recoverStatus = RecoverStatus.initial;
  String message = '';

  Future<void> recoverEmail(String email) async {
    recoverStatus = RecoverStatus.loading;
    notifyListeners();
    final String? auth = await firebaseAuth.recovery(email: email);

    if (auth == null) {
      message = 'Verifique sua caixa de e-mail em: $email';
      recoverStatus = RecoverStatus.success;
      notifyListeners();
    } else {
      message = auth;
      notifyListeners();
      recoverStatus = RecoverStatus.error;
      notifyListeners();
    }
  }
}

