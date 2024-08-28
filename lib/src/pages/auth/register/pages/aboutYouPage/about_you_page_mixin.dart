import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/model/persons_model.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouPage/cep_controller_you.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/image_profile_controller_account.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin AboutYouPageMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController malePersonEC = TextEditingController();
  final TextEditingController cpfEC = TextEditingController();
  final TextEditingController birthEC = TextEditingController();
  final TextEditingController whastAppPersonEC = TextEditingController();
  final TextEditingController zipCodePersonEC = TextEditingController();
  final TextEditingController streetPersonEC = TextEditingController();
  final TextEditingController districtPersonEC = TextEditingController();
  final TextEditingController numberPersonEC = TextEditingController();
  final TextEditingController complementPersonEC = TextEditingController();
  final TextEditingController cityPersonEC = TextEditingController();
  final TextEditingController statePersonEC = TextEditingController();

  final FocusNode malePersonFocus = FocusNode();
  final FocusNode cpfFocus = FocusNode();
  final FocusNode birthFocus = FocusNode();
  final FocusNode whastAppPersonFocus = FocusNode();
  final FocusNode zipCodePersonFocus = FocusNode();
  final FocusNode streetPersonFocus = FocusNode();
  final FocusNode districtPersonFocus = FocusNode();
  final FocusNode numberPersonFocus = FocusNode();
  final FocusNode complementPersonFocus = FocusNode();
  final FocusNode cityPersonFocus = FocusNode();
  final FocusNode statePersonFocus = FocusNode();
  final FocusNode confimAddresFocus = FocusNode();

  final RegisterController registerController = getIt();
  final ImageProfileControllerAccount imageProfileController = getIt();
  final CepControllerYou cepController = getIt();

  final debounce = Debounce();

  @override
  void initState() {
    registerController.addListener(_checkDataAboutYou);
    super.initState();
  }

  @override
  void dispose() {
    //TextEditingController
    malePersonEC.dispose();
    cpfEC.dispose();
    birthEC.dispose();
    whastAppPersonEC.dispose();
    zipCodePersonEC.dispose();
    streetPersonEC.dispose();
    numberPersonEC.dispose();
    complementPersonEC.dispose();
    cityPersonEC.dispose();
    statePersonEC.dispose();
    //FocusNode
    malePersonFocus.dispose();
    cpfFocus.dispose();
    birthFocus.dispose();
    whastAppPersonFocus.dispose();
    zipCodePersonFocus.dispose();
    streetPersonFocus.dispose();
    numberPersonFocus.dispose();
    complementPersonFocus.dispose();
    cityPersonFocus.dispose();
    statePersonFocus.dispose();
    super.dispose();
  }

  void _onTextFieldChange() {
    log('IMAGE AVATAR: ${imageProfileController.urlImage}');
    log('ABOUT YOU: Enviando dados para controller.');
    PersonsModel personModel = PersonsModel(
      malePerson: malePersonEC.text,
      namePerson: registerController.dataAcountPage['userName'],
      imageAvatar: imageProfileController.urlImage,
      cpf: cpfEC.text,
      birth: birthEC.text,
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
    if (registerController.submitFormYou()) _onTextFieldChange();
  }
}
