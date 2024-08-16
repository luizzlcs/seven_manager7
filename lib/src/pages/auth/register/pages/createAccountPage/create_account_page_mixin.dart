import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/model/user_model.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin CreateAccountPageMixin<T extends StatefulWidget> on State<T> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmePasswordEC = TextEditingController();

  final RegisterController registerController = getIt();
  final debounce = Debounce();

  @override
  void initState() {
    confirmePasswordEC.addListener(() {
      registerController.checkPasswordsMatch(
          passwordEC.text, confirmePasswordEC.text);
    });
    passwordEC.addListener(() {
      registerController.checkPasswordsMatch(
          passwordEC.text, confirmePasswordEC.text);
    });

    registerController.addListener(_checkDataAccount);

    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    confirmePasswordEC.dispose();
    registerController.removeListener(_checkDataAccount);
    super.dispose();
  }

  void _onTextFieldChange() {
   
      log('ACCOUNT: Enviando dados para controller.');
      UserModel userModel = UserModel(
        userName: nameEC.text,
        userEmail: emailEC.text,
        userPassword: passwordEC.text,
      );
      Map<String, dynamic> userMap = userModel.toMap();

      registerController.changeDataAcountPage(userMap);
 
  }

  void _checkDataAccount() {
  
      if (registerController.submitFormAcount()) _onTextFieldChange();
  }
}
