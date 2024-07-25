import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';

import '../../../core/widgets/helpers/messages.dart';

enum Status { none, error, sucess, loading }

class LoginController with ChangeNotifier {
  LoginController({
    required this.firebaseAuth,
  });

  bool isVisible = false;
  bool isLoading = false;
  String statusMessage = '';
  final FirebaseAuthService firebaseAuth;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();

  void changeVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final valid = formKey.currentState?.validate() ?? false;
    String email = emailEC.text;
    String password = passwordEC.text;

    if (valid) {
      isLoading = true;
      notifyListeners();
      final String? auth =
          await firebaseAuth.signInWithEmail(email: email, password: password);

      if (auth == null) {
        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.of(context).pushNamed(AppRouter.homePage),
        );
      } else {
        statusMessage = auth;
        Messages.showError(auth, context);
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
