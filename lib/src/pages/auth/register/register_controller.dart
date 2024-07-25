import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';

class RegisterController with ChangeNotifier {
  RegisterController({
    required this.firebaseAuth,
  });

  final FirebaseAuthService firebaseAuth;

  bool isVisible = false;
  bool passwordMatch = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmePasswordEC = TextEditingController();

  
  void changeVisible(){
    isVisible = !isVisible;
    notifyListeners();
  }

  void checkPasswordsMatch() {
    
    String password = passwordEC.text;
    String confirmePassword = confirmePasswordEC.text;
    passwordMatch = password == confirmePassword;
    notifyListeners();
  }
}
