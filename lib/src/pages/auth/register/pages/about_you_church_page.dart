import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';
import 'package:seven_manager/src/core/widgets/helpers/seven_loader.dart';
import 'package:seven_manager/src/pages/auth/login/widgets/image_logo_widget.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/constants/app_router.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/seven_manager_theme.dart';
import '../../../../core/widgets/helpers/messages.dart';
import '../register_controller.dart';

class AboutYouChurchPage extends StatefulWidget {
  const AboutYouChurchPage({super.key});

  @override
  State<AboutYouChurchPage> createState() => _AboutYouChurchPageState();
}

class _AboutYouChurchPageState extends State<AboutYouChurchPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController zipCodeChuchsEC = TextEditingController();
  final TextEditingController streetChuchsEC = TextEditingController();
  final TextEditingController districtChuchsEC = TextEditingController();
  final TextEditingController cityChuchsEC = TextEditingController();
  final TextEditingController stateChuchsEC = TextEditingController();

  final RegisterController registerController = getIt();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    zipCodeChuchsEC.dispose();
    streetChuchsEC.dispose();
    districtChuchsEC.dispose();
    cityChuchsEC.dispose();
    stateChuchsEC.dispose();
    registerController.removeListener(_registerStatusChange);
    super.dispose();
  }

  void _registerStatusChange() {
    switch (registerController.registerStatus) {
      case RegisterStatus.initial:
        break;
      case RegisterStatus.loading:
        break;
      case RegisterStatus.success:
        Navigator.of(context).pushNamed(AppRouter.homePage);
        Messages.showSuccess(registerController.message, context);
        break;
      case RegisterStatus.error:
        Messages.showError(registerController.message, context);
    }
  }

  Future<void> _formSubmit() async {
    final valid = formKey.currentState?.validate() ?? false;

    if (valid) {
      registerController.createChurchs(
        zipCodeChuchs: zipCodeChuchsEC.text,
        streetChuchs: streetChuchsEC.text,
        districtChuchs: districtChuchsEC.text,
        cityChuchs: cityChuchsEC.text,
        stateChuchs: stateChuchsEC.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: SevenManagerTheme.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '3. Sobre sua Igreja',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SevenManagerTheme.tealBlue,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const ImageLogoWidget(pathImage: AppImages.logoIasd),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: zipCodeChuchsEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: streetChuchsEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: districtChuchsEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: cityChuchsEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: stateChuchsEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedBuilder(
                        animation: registerController,
                        builder: (context, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              registerController.registerStatus ==
                                      RegisterStatus.loading
                                  ? const SevenLoader()
                                  : AnimatedBuilder(
                                      animation: registerController,
                                      builder: (context, child) {
                                        print('AnimatedBuild rebuild');
                                        return ElevatedButton.icon(
                                          onPressed: () {
                                                                                       
                                              log('${registerController.dataAcountPage}');
                                              log('${registerController.dataAcountPage['userName']}');
                                              log('${registerController.dataAcountPage['userPassword']}');
                                              log('VARIÁVEL isVisible: ${registerController.isVisible}');
                                              log('EMAIL: ${registerController.emailUser}');
                                            
                                          },
                                          label: const Text('Avançar'),
                                          icon:
                                              const Icon(Icons.account_circle),
                                        );
                                      },
                                    ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
