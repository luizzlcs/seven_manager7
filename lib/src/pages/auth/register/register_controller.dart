import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';

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

  void createUser(BuildContext context)async{
    String name = nameEC.text;
    String email = emailEC.text;
    String password = passwordEC.text;
    final valid = formKey.currentState?.validate()?? false;
    if(valid){
    final String? auth = await firebaseAuth.createUser(email: email, password: password, name: name);
      if(auth == null){
        checkPasswordsMatch();
        Messages.showInfo('Usuário Criado com suceso!', context);
      }else{
        checkPasswordsMatch();
        Messages.showError(auth, context);
      }

    }

  }
}
