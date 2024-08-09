import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';
import 'package:seven_manager/src/model/persons_model.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterController with ChangeNotifier {
  RegisterController({required this.firebaseAuth});

  final AuthServiceFirebaseImpl firebaseAuth;

  RegisterStatus registerStatus = RegisterStatus.initial;
  bool isVisible = false;
  bool passwordMatch = true;
  String message = '';
  String emailUser = '';

  Map<String, dynamic> dataAcountPage= {'name': 'Luiz'};
  var dataAboutYouPage;
  var dataChurchPage;

  

  

  void changeVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void checkPasswordsMatch(String password, String confirmPassword) {
    passwordMatch = password == confirmPassword;
    notifyListeners();
  }

  void callFormSubmit({required Function formSubmitFunction}) {
    formSubmitFunction();
  }

  Future<void> createChurchs(
      {required String zipCodeChuchs,
      required String streetChuchs,
      required String districtChuchs,
      required String cityChuchs,
      required String stateChuchs}) async {
    Future<void> churchModel = firebaseAuth.createChurchs(
      districtChuchs: districtChuchs,
      cityChuchs: cityChuchs,
      zipCodeChuchs: zipCodeChuchs,
      streetChuchs: streetChuchs,
      stateChuchs: stateChuchs,
    );
  }

  void changeDataAcountPage(Map<String, dynamic> data){
    log('Chamando método changeDataAcountPage: $data');
    emailUser = 'luizzlcs@gmail.com';
    dataAcountPage.addAll(data);
    log('Controller: dataAcountPage: $dataAcountPage');
    notifyListeners();

  }

  Future<void> createPerson({
    required String namePerson,
    required String dateOfBirthPerson,
    required String cpf,
    required String malePerson,
    required String whastAppPerson,
    required String numberPerson,
    required String cityPerson,
    required String zipCodePerson,
    required String statePerson,
    required String streetPerson,
    String? complementPerson,
    bool isPostalServicePerson = false,
    String? photoURL,
  }) async {
    var personModel = PersonsModel(
      malePerson: malePerson,
      namePerson: namePerson,
      dateOfBirthPerson: dateOfBirthPerson,
      cpf: cpf,
      emailPerson: emailUser,
      whastAppPerson: whastAppPerson,
      streetPerson: streetPerson,
      zipCodePerson: zipCodePerson,
      complementPerson: complementPerson,
      numberPerson: numberPerson,
      cityPerson: cityPerson,
      statePerson: statePerson,
    );
  }

  Future<void> createUser({
    required String namePerson,
    required String emailPerson,
    required String password,
  }) async {
    registerStatus = RegisterStatus.loading;

    notifyListeners();

    var auth = await firebaseAuth.createUser(
      namePerson: namePerson,
      emailPerson: emailPerson,
      password: password,
    );

    if (auth == null) {
      message = 'Você logu pela 1ª vez com $emailPerson';
      notifyListeners();
      registerStatus = RegisterStatus.success;
      notifyListeners();
    } else {
      message = auth;
      registerStatus = RegisterStatus.error;
      notifyListeners();
    }
  }
}
