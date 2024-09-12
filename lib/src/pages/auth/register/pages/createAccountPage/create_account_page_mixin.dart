import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/model/user_model.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/image_profile_controller_account.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin CreateAccountPageMixin<T extends StatefulWidget> on State<T> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmePasswordEC = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmePasswordFocus = FocusNode();

  final RegisterController registerController = getIt();
  final ImageProfileControllerAccount imageProfileController = getIt();
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
    //TextEditingController
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    confirmePasswordEC.dispose();
    //FocusNode
    nameFocus.dispose();
    emailFocus.dispose();
    registerController.removeListener(_checkDataAccount);
    super.dispose();
  }

  void _onTextFieldChange() {
    log('ACCOUNT: Enviando dados para controller.');
    UserModel userModel = UserModel(
      idUser: '021',
      userName: nameEC.text,
      userEmail: emailEC.text,
      userPassword: passwordEC.text,
    );

    var UserModel(userName: name, userEmail: email, userPassword: password) =
        userModel;

    Map<String, dynamic> userMap = {
      'userName': name,
      'userEmail': email,
      'userPassword': password,
    };

    registerController.changeDataAcountPage(userMap);
  }

  void _checkDataAccount() {
    if (registerController.submitFormAcount()) _onTextFieldChange();
  }
}
