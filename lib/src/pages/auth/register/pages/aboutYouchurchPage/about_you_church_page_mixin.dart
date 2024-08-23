import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/model/churchs_model.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/image_profile_controller_church.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';

mixin AboutYouChurchPageMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController zipCodeChuchsEC = TextEditingController();
  final TextEditingController streetChuchsEC = TextEditingController();
  final TextEditingController districtChuchsEC = TextEditingController();
  final TextEditingController cityChuchsEC = TextEditingController();
  final TextEditingController stateChuchsEC = TextEditingController();

  final FocusNode zipCodeChuchsFocus = FocusNode();
  final FocusNode streetChurchsFocus = FocusNode();
  final FocusNode districtChurchsFocus = FocusNode();
  final FocusNode cityChurchsFocus = FocusNode();
  final FocusNode stateChurchsFocus = FocusNode();

  final debouce = Debounce();

  final RegisterController registerController = getIt();
  final ImageProfileControllerChurch _imageController = getIt();
 

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
    log('IMAGE LOGO CHURCH: ${_imageController.urlImage}');
    log('CHURCH MIXIN: Enviando dados para controller.');

    ChurchsModel churchModel = ChurchsModel(
      urlImageLogo: _imageController.urlImage ,
      districtChuchs: districtChuchsEC.text,
      cityChuchs: cityChuchsEC.text,
      zipCodeChuchs: zipCodeChuchsEC.text,
      streetChuchs: streetChuchsEC.text,
      stateChuchs: stateChuchsEC.text,
      creationDate: DateTime.now().toIso8601String()
    );
    Map<String, dynamic> churchMap = churchModel.toMap();

     registerController.changeDataChurchPage(churchMap);
  }

  void _checkDataAboutChurch() {
    if ( registerController.submitFormChurch()) _onTextFieldChange();
  }
}
