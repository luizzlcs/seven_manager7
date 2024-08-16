import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';

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

    notifyListeners();
  }

  void changeDataAboutYouPage(Map<String, dynamic> data) {
    
      dataAboutYouPage.addAll(data);
      log('DADOS YOU: $dataAboutYouPage');
    

    notifyListeners();
  }

  void changeDataChurchPage(Map<String, dynamic> data) {
    dataChurchPage.addAll(data);
    log('DADOS CHURCH: $dataChurchPage');
  
      
    notifyListeners();
  }

  Future<void> createUser() async {
    registerStatus = RegisterStatus.loading;

    notifyListeners();

    var auth = await firebaseAuth.createUser(
      namePerson: dataAcountPage['userName'],
      emailPerson: dataAcountPage['userEmail'],
      password: dataAcountPage['userPassword'],
    );

    if (auth == null) {
      message = 'Você logu pela 1ª vez com ${dataAcountPage['userEmail']}';
      notifyListeners();
      registerStatus = RegisterStatus.success;
      notifyListeners();
    } else {
      message = auth;
      registerStatus = RegisterStatus.error;
      notifyListeners();
    }
  }

  Future<void> createChurchs() async {
    await firebaseAuth.createChurchs(
      districtChuchs: dataChurchPage['districtChuchs'],
      cityChuchs: dataChurchPage['cityChuchs'],
      zipCodeChuchs: dataChurchPage['zipCodeChuchs'],
      streetChuchs: dataChurchPage['streetChuchs'],
      stateChuchs: dataChurchPage['stateChuchs'],
    );
  }

  Future<void> createPerson() async {
    await firebaseAuth.createPersons(
      namePerson: dataAboutYouPage['namePerson'],
      emailPerson: dataAboutYouPage['emailPerson'],
      dateOfBirthPerson: dataAboutYouPage['dateOfBirthPerson'],
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
  }
}
