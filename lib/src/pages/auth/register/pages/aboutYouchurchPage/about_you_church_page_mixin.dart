import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/model/churchs_model.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin AboutYouChurchPageMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController zipCodeChuchsEC = TextEditingController();
  final TextEditingController streetChuchsEC = TextEditingController();
  final TextEditingController districtChuchsEC = TextEditingController();
  final TextEditingController cityChuchsEC = TextEditingController();
  final TextEditingController stateChuchsEC = TextEditingController();

  final debouce = Debounce();

  final RegisterController registerController = getIt();

  @override
  void initState() {
    registerController.addListener(_checkDataAboutChurch);
    super.initState();
  }

  @override
  void dispose() {
    zipCodeChuchsEC.dispose();
    streetChuchsEC.dispose();
    districtChuchsEC.dispose();
    cityChuchsEC.dispose();
    stateChuchsEC.dispose();
    registerController.removeListener(_checkDataAboutChurch);
    super.dispose();
  }

  void _onTextFieldChange() {
    log('CHURCH MIXIN: Enviando dados para controller.');

    ChurchsModel churchModel = ChurchsModel(
      districtChuchs: districtChuchsEC.text,
      cityChuchs: cityChuchsEC.text,
      zipCodeChuchs: zipCodeChuchsEC.text,
      streetChuchs: streetChuchsEC.text,
      stateChuchs: stateChuchsEC.text,
    );
    Map<String, dynamic> churchMap = churchModel.toMap();

    registerController.changeDataChurchPage(churchMap);
  }

  void _checkDataAboutChurch() {
    if (registerController.submitFormChurch()) _onTextFieldChange();
  }
}
