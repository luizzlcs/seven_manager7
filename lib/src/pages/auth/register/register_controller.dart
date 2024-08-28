import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterController with ChangeNotifier {
  RegisterController({required this.firebaseAuth});

  final AuthServiceFirebaseImpl firebaseAuth;
  final GlobalKey<FormState> formKeyAccount = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyYou = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyChurch = GlobalKey<FormState>();

  RegisterStatus registerStatus = RegisterStatus.initial;

  String sexOption = 'Masculino';
  bool confirmAddress = false;
  bool isVisible = false;
  bool passwordMatch = true;
  String message = '';

  bool _checkValid = false;
  bool get checkValid => _checkValid;

  Map<String, dynamic> dataAcountPage = {};
  Map<String, dynamic> dataAboutYouPage = {};
  Map<String, dynamic> dataChurchPage = {};

  void setCheckValid() {
    _checkValid = true;
    notifyListeners();
  }

  void resetCheckValid() {
    _checkValid = false;
    notifyListeners();
  }

  bool submitFormAcount() {
    return formKeyAccount.currentState?.validate() ?? false;
  }

  bool submitFormYou() {
    return formKeyYou.currentState?.validate() ?? false;
  }

  bool submitFormChurch() {
    return formKeyChurch.currentState?.validate() ?? false;
  }

  void changeVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void changeConfirmAddress() {
    confirmAddress = !confirmAddress;
    notifyListeners();
  }

  void changeSexOptions(String option) {
    sexOption = option;
    notifyListeners();
  }

  void checkPasswordsMatch(String password, String confirmPassword) {
    passwordMatch = password == confirmPassword;
    notifyListeners();
  }

  void callFormSubmit({required Function formSubmitFunction}) {
    formSubmitFunction();
  }

  void changeDataAcountPage(Map<String, dynamic> data) {
    dataAcountPage.addAll(data);
    log('DADOS ACCOUNT: $dataAcountPage');
  }

  void changeDataAboutYouPage(Map<String, dynamic> data) {
    dataAboutYouPage.addAll(data);
    log('DADOS YOU: $dataAboutYouPage');
  }

  void changeDataChurchPage(Map<String, dynamic> data) {
    dataChurchPage.addAll(data);
    log('DADOS CHURCH: $dataChurchPage');
  }

  void changeRegisterStatusLoading() {
    registerStatus = RegisterStatus.loading;
    notifyListeners();
  }

  void changeRegisterStatusInitial() {
    registerStatus = RegisterStatus.initial;
    notifyListeners();
  }

  Future<void> createUser(context) async {
    registerStatus = RegisterStatus.loading;
    notifyListeners();
    log('REGISTER STATUS: $registerStatus');

    String? userId = await firebaseAuth.createUser(
      namePerson: dataAcountPage['userName'],
      imageAvatar: dataAboutYouPage['imageAvatar'],
      emailPerson: dataAcountPage['userEmail'],
      password: dataAcountPage['userPassword'],
      urlImageLogo: dataChurchPage['urlImageLogo'],
      districtChuchs: dataChurchPage['districtChuchs'],
      cityChuchs: dataChurchPage['cityChuchs'],
      zipCodeChuchs: dataChurchPage['zipCodeChuchs'],
      streetChuchs: dataChurchPage['streetChuchs'],
      stateChuchs: dataChurchPage['stateChuchs'],
      birth: dataAboutYouPage['birth'],
      cpf: dataAboutYouPage['cpf'],
      malePerson: sexOption,
      whastAppPerson: dataAboutYouPage['whastAppPerson'],
      numberPerson: dataAboutYouPage['numberPerson'],
      cityPerson: dataAboutYouPage['cityPerson'],
      zipCodePerson: dataAboutYouPage['zipCodePerson'],
      statePerson: dataAboutYouPage['statePerson'],
      streetPerson: dataAboutYouPage['streetPerson'],
      isPostalServicePerson: dataAboutYouPage['isPostalServicePerson'],
    );
    log('>>> ERRO AO CRIAR USUÁRIO: $userId');
    if (userId != null) {
      log('REGISTER STATUS: Erro!!!');
      Messages.showError(message, context);
      message = userId;
      registerStatus = RegisterStatus.error;
      notifyListeners();
      registerStatus = RegisterStatus.initial;
      userId = null;
      notifyListeners();
    } else {
      registerStatus = RegisterStatus.success;
      message = 'Usuário: ${dataAcountPage['userEmail']} criado com sucesso!';
      log('REGISTER STATUS: Sucesso!!!');
      notifyListeners();
      registerStatus = RegisterStatus.initial;
      Navigator.of(context).pushReplacementNamed(AppRouter.login);
      Messages.showInfo(message, context);
      message = '';
      notifyListeners();
    }
  }
}
