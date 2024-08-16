import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/model/persons_model.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin AboutYouPageMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController malePersonEC = TextEditingController();
  final TextEditingController cpfEC = TextEditingController();
  final TextEditingController dateOfBirthPersonEC = TextEditingController();
  final TextEditingController whastAppPersonEC = TextEditingController();
  final TextEditingController zipCodePersonEC = TextEditingController();
  final TextEditingController streetPersonEC = TextEditingController();
  final TextEditingController numberPersonEC = TextEditingController();
  final TextEditingController complementPersonEC = TextEditingController();
  final TextEditingController cityPersonEC = TextEditingController();
  final TextEditingController statePersonEC = TextEditingController();

  final RegisterController registerController = getIt();

  final debounce = Debounce();

  @override
  void initState() {
    registerController.addListener(_checkDataAboutYou);
    super.initState();
  }

  @override
  void dispose() {
    malePersonEC.dispose();
    cpfEC.dispose();
    dateOfBirthPersonEC.dispose();
    whastAppPersonEC.dispose();
    zipCodePersonEC.dispose();
    streetPersonEC.dispose();
    numberPersonEC.dispose();
    complementPersonEC.dispose();
    cityPersonEC.dispose();
    statePersonEC.dispose();
    super.dispose();
  }

  void _onTextFieldChange() {
    log('ABOUT YOU: Enviando dados para controller.');
    PersonsModel personModel = PersonsModel(
      malePerson: malePersonEC.text,
      cpf: cpfEC.text,
      dateOfBirthPerson: dateOfBirthPersonEC.text,
      whastAppPerson: whastAppPersonEC.text,
      zipCodePerson: zipCodePersonEC.text,
      streetPerson: streetPersonEC.text,
      numberPerson: numberPersonEC.text,
      complementPerson: complementPersonEC.text,
      cityPerson: cityPersonEC.text,
      statePerson: statePersonEC.text,
      isPostalServicePerson: registerController.confirmAddress,
    );
    Map<String, dynamic> personMap = personModel.toMap();

    registerController.changeDataAboutYouPage(personMap);
  }

  void _checkDataAboutYou() {
    debounce.run(() {
      log('CHECK-VALID YOU:  ${registerController.checkValid}');
      if (registerController.checkValid) _onTextFieldChange();
    });
  }
}
